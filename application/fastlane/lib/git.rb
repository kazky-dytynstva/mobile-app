# Returns a change log, based on the git history with no more than 50 lines
def gitChangeLog(version)
  Dir.chdir("../") do
    gitlog = sh "git log | head -n50"
    return "Version: #{version}\n\n#{gitlog}"
  end
end

def getOneLineChangelog()
 return sh "git log --oneline -n 20"
end

# Returns the last known git tag
def getLastGitTag()
  return `git describe --tags | tr -d '\n'`
end