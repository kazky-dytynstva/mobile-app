####
#### Private lanes, that we only call internally
####

desc "Execute flutter build cmd"
private_lane :flutter_build do |options|
  if options[Options::CLEAN]
    clean(options)
    build_runner(options)
  end

  dartDefines = getDefines(options).map { |k, v| " --dart-define=#{k}=\"#{v}\"" }.reduce("", :+)

  versionName = options[Options::VERSION_NAME]
  versionCode = options[Options::VERSION_CODE]
  platform = options[Options::PLATFORM]
  stagingConfigs = Config::STAGING_MATRIX[options[Options::STAGING]]
  type = stagingConfigs[Keys::RELEASE_BUILD] ? "--release" : "--debug"
  plistExport = isAndroid(options) ? "" : "--export-options-plist=ios/Runner/exportOptions.plist"
  target = isIos(options) ? "ipa" : options[Options::ANDROID_OUTPUT]


  flutter("build #{target} #{type} #{plistExport} --build-number=#{versionCode} --build-name=#{versionName} #{dartDefines}")
end

desc "Prepare platform extra files"
private_lane :prepare_platform_files do |options|
  if isAndroid(options)
    prepare_android_files(options)
  else
    prepare_ios_files(options)
  end
end

desc "Prepare ios extra files"
private_lane :prepare_ios_files do |options|
  staging = options[Options::STAGING]
  iosConfigs = Config::IOS_BUILD_CONFIG[staging]
  platformConfigs = Config::STAGING_MATRIX[staging][Platforms::IOS]

  setProperties("../ios/Flutter/CustomDefine.xcconfig", getDefines(options))

  infoPlistFilePath = ""
  if isStagingProd(options)
    infoPlistFilePath = "../ios/firebase_config/prod/GoogleService-Info.plist"
    UI.user_error! "GoogleService-Info.plist not provided" unless File.file?(infoPlistFilePath)
  else
    infoPlistFilePath = "../ios/firebase_config/dev/GoogleService-Info.plist"
    UI.user_error! "GoogleService-Info.plist not provided" unless File.file?(infoPlistFilePath)
  end
  FileUtils.cp(infoPlistFilePath, "../ios/Runner/")
  UI.important "GoogleService-Info.plist was copied 😉"

  # set keychain
  password="IOS_PROVISIONING_PASSWORD"
  UI.user_error!("No #{password} provided!") unless ENV.key?(password)

  begin
    delete_keychain(name: FASTLANE_KEYCHAIN_NAME)
  rescue Exception
  end
  create_keychain(
    name: FASTLANE_KEYCHAIN_NAME,
    default_keychain: is_ci ? true : false,
    unlock: true,
    timeout: 0,
    lock_when_sleeps: false,
    password: "",
  )
  import_certificate(
    certificate_path: "ios/profiles/distribution_certificate.p12",
    certificate_password: ENV[password],
    keychain_name: FASTLANE_KEYCHAIN_NAME,
    keychain_password: "",
  )
  provisioningProfilePath = iosConfigs[Keys::PROVISIONING_PROFILE_PATH]
  install_provisioning_profile(path: provisioningProfilePath)

  create_export_options_plist(options)

  UI.important "IOS platform files prepared 💪"
end

desc "Creates and exportOptions.plist file, that required for creating .ipa file"
private_lane :create_export_options_plist do |options|
  defines = getDefines(options)

  buildMethod = defines[DfKeys::BUILD_METHOD]
  team = defines[DfKeys::DEVELOPMENT_TEAM]
  appId = defines[DfKeys::APP_ID]
  provisioningProfile = defines[DfKeys::PROVISIONING_PROFILE]

  exportOptions = StringIO.new()
  exportOptions.write("<?xml version=”1.0” encoding=”UTF-8”?>\n")
  exportOptions.write("<!DOCTYPE plist PUBLIC “-//Apple//DTD PLIST 1.0//EN” “http://www.apple.com/DTDs/PropertyList-1.0.dtd”>\n")
  exportOptions.write("<plist version=”1.0”>\n")
  exportOptions.write("  <dict>\n")
  exportOptions.write("    <key>method</key>\n")
  exportOptions.write("    <string>#{buildMethod}</string>\n")
  exportOptions.write("    <key>teamID</key>\n")
  exportOptions.write("    <string>#{team}</string>\n")
  exportOptions.write("    <key>provisioningProfiles</key>\n")
  exportOptions.write("    <dict>\n")
  exportOptions.write("      <key>#{appId}</key>\n")
  exportOptions.write("      <string>#{provisioningProfile}</string>\n")
  exportOptions.write("    </dict>\n")
  exportOptions.write("  </dict>\n")
  exportOptions.write("</plist>")

  file = File.new("../ios/Runner/exportOptions.plist", "w")
  file.write(exportOptions.string)
  file.close

  UI.important "exportOptions.plist created"
end

desc "Prepare android extra files"
private_lane :prepare_android_files do |options|
  androidConfigs = Config::ANDROID_BUILD_CONFIG[options[Options::STAGING]]
  setProperties("../android/key.properties", androidConfigs)

  if isStagingDev(options)
    filePath = "../android/app/src/debug/google-services.json"
    UI.user_error! "google-services.json for debug not provided" unless File.file?(filePath)
  elsif isStagingInternal(options)
    FileUtils.cp("../android/app/src/release/google-services.json", "../android/app/src/release/google-services(original).json")
    FileUtils.cp("../android/app/src/debug/google-services.json", "../android/app/src/release/")
    UI.important "dev google-services.json was copied to release folder 😉"
  else
    filePath = "../android/app/src/release/google-services.json"
    UI.user_error! "google-services.json for release not provided" unless File.file?(filePath)
  end

  UI.important "Android platform files prepared 💪"
end

desc "Fix platform files after builds"
private_lane :cleanup_platform_files do |options|
    if isIos(options)
      delete_keychain(name: FASTLANE_KEYCHAIN_NAME)
      next
    end

    if !isStagingInternal(options)
        next
    end

    FileUtils.cp("../android/app/src/release/google-services(original).json", "../android/app/src/release/google-services.json")
    File.delete("../android/app/src/release/google-services(original).json")
    UI.important "dev google-services.json was deleted the release folder 😉"
end


####
#### Private helper methods
####

def flutter(args)
  Dir.chdir("..") do
    sh "flutter #{args}"
  end
end

def shell(args)
  Dir.chdir("..") do
    sh(args)
  end
end

def isIos(options)
    return options[Options::PLATFORM] == Platforms::IOS
end

def isAndroid(options)
    return options[Options::PLATFORM] == Platforms::ANDROID
end

def isStagingDev(options)
  staging = options[Options::STAGING]
  return staging == Stagings::DEV
end

def isStagingInternal(options)
  staging = options[Options::STAGING]
  return staging == Stagings::INTERNAL
end

def isStagingProd(options)
  staging = options[Options::STAGING]
  return staging == Stagings::PROD
end

def getDefines(options)
  staging = options[Options::STAGING]
  stagingConfigs = Config::STAGING_MATRIX[staging]
  platform = options[Options::PLATFORM]
  platformConfigs = stagingConfigs[platform]

  type = stagingConfigs[Keys::RELEASE_BUILD] ? "--release" : "--debug"
  appName = platformConfigs[Keys::APP_NAME]
  appId = platformConfigs[Keys::APP_ID]

  defines = {
    DfKeys::APP_ID => appId,
    DfKeys::APP_NAME => appName,
    DfKeys::STAGE_NAME => staging,
  }
  if isIos(options)
    iosConfigs = Config::IOS_BUILD_CONFIG[staging]
    defines[DfKeys::PROVISIONING_PROFILE] = iosConfigs[Keys::PROVISIONING_PROFILE_NAME]
    defines[DfKeys::CERTIFICATE] = iosConfigs[Keys::CERTIFICATE_NAME]
    defines[DfKeys::BUILD_METHOD] = iosConfigs[Keys::BUILD_METHOD]
    defines[DfKeys::DEVELOPMENT_TEAM] = iosConfigs[Keys::DEVELOPMENT_TEAM]
  end
  return defines
end
