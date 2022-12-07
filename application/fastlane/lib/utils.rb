# Reads and sets properties in a file
def setProperties(path, hash)
  if File.file?(path)
    loadedProperties = loadProperties(path)
    hash = loadedProperties.merge(hash)
  end
  File.delete(path) if File.exist?(path)
  File.open(path, "w") do |fo|
    hash.each do |key, value|
      fo.write("#{key}=#{value}\n")
    end
  end
end

def loadProperties(propertiesFilename)
  properties = {}
  if File.file?(propertiesFilename)
    File.open(propertiesFilename, "r") do |properties_file|
      properties_file.read.each_line do |line|
        line.strip!
        if (line[0] != ?# and line[0] != ?=)
          i = line.index("=")
          if (i)
            properties[line[0..i - 1].strip] = line[i + 1..-1].strip
          else
            properties[line] = ""
          end
        end
      end
    end
  end
  properties
end


def getLastModifiedForFile(path)
  lastModifiedLocal = nil
  if File.file?(path)
    lastModifiedLocal = File.mtime(path)
  end
  return lastModifiedLocal
end