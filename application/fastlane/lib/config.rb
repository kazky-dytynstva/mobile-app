##
# This class used just here, inside current file
#
class BaseClass
  def self.all_variables
    constants.map &self.method(:const_get)
  end
end

class Config
  class Keys
    APP_ID = "id"
    APP_NAME = "name"
    ANDROID_KEY_ALIAS = "key_alias"
    ANDROID_KEY_PASS = "key_password"
    ANDROID_STORE_PASS = "store_password"
    ANDROID_STORE_FILE_NAME = "store_file_name"
  end
  class DfKeys
    APP_ID = "DF_APP_ID"
    APP_NAME = "DF_APP_NAME"
    STAGE_NAME = "DF_STAGE_NAME"
    PROVISIONING_PROFILE = "DF_PROVISIONING_PROFILE"
    CERTIFICATE = "DF_CERTIFICATE"
    DEVELOPMENT_TEAM = "DF_DEVELOPMENT_TEAM"
  end

  class Platforms < BaseClass
    ANDROID = "android"
    IOS = "ios"
  end

  class AndroidOutputs < BaseClass
    APK = "apk"
    APP_BUNDLE = "appbundle"
  end

  class Stagings < BaseClass
    PROD = "prod"
    INTERNAL = "internal"
    DEV = "dev"
  end

  class Options < BaseClass
    # Variables: Platforms
    PLATFORM = :platform
    # Variables: Stagings
    STAGING = :staging
    # Variables: AndroidOutputs
    ANDROID_OUTPUT = :android_output
    # Variables: true, false
    WATCH = :watch
    # Variables: true, false
    CLEAN = :clean
    # Variables: true, false
    UPLOAD_TO_STORE = :upload_to_store
    # Variables: true, false
    COVERAGE = :coverage
    # App version name, e.g. "5.3.1"
    VERSION_NAME = :version_name
    # App version code, e.g. 145
    VERSION_CODE = :version_code
  end

  STAGING_CONFIGS = {
    Stagings::PROD => {
      Platforms::IOS => {
        Keys::APP_ID => "ua.andriyantonov.tales",
        Keys::APP_NAME => "Kaзки",
      },
      Platforms::ANDROID => {
        Keys::APP_ID => "ua.andriyantonov.tales",
        Keys::APP_NAME => "Казки",
      },
    },
    Stagings::INTERNAL => {
      Platforms::IOS => {
        Keys::APP_ID => "ua.andriyantonov.tales.dev",
        Keys::APP_NAME => "Kaзки[i]",
      },
      Platforms::ANDROID => {
        Keys::APP_ID => "ua.andriyantonov.tales.dev",
        Keys::APP_NAME => "Казки[i]",
      },
    },
    Stagings::DEV => {
      Platforms::IOS => {
        Keys::APP_ID => "ua.andriyantonov.tales.dev",
        Keys::APP_NAME => "Kaзки[d]",
      },
      Platforms::ANDROID => {
        Keys::APP_ID => "ua.andriyantonov.tales.dev",
        Keys::APP_NAME => "Казки[d]",
      },
    },
  }

  class IosBuildConfigKeys
    PROVISIONING_PROFILE_PATH = "provisioning_profile_path"
    PROVISIONING_PROFILE_NAME = "provisioning_profile_name"
    CERTIFICATE_NAME = "certificate_name"
    DEVELOPMENT_TEAM = "development_team"
  end

  IOS_BUILD_CONFIG = {
    Stagings::INTERNAL => {
        IosBuildConfigKeys::PROVISIONING_PROFILE_PATH => "ios/profiles/Kazky_Provisioning_Profile_internal.mobileprovision",
        IosBuildConfigKeys::PROVISIONING_PROFILE_NAME => "Kazky Provisioning Profile (internal)",
        IosBuildConfigKeys::CERTIFICATE_NAME => "Apple Distribution: Andrii Antonov (LV9VG69R9U)",
        IosBuildConfigKeys::DEVELOPMENT_TEAM => "LV9VG69R9U",
      },
    Stagings::PROD => {
        IosBuildConfigKeys::PROVISIONING_PROFILE_PATH => "ios/profiles/Kazky_Provisioning_Profile_prod.mobileprovision",
        IosBuildConfigKeys::PROVISIONING_PROFILE_NAME => "Kazky Provisioning Profile (prod)",
        IosBuildConfigKeys::CERTIFICATE_NAME => "Apple Distribution: Andrii Antonov (LV9VG69R9U)",
        IosBuildConfigKeys::DEVELOPMENT_TEAM => "LV9VG69R9U",
      },
    }
end


