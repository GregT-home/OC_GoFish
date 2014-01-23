#task :default => [:spec] do
task :default do
  # no default task, currently
end

task :clean do
#  files = Dir["*~", "*/*~", "*/*/*~"].join(" ")
#  sh "rm #{files}"
  sh 'find . -name "*~" -exec rm -v {} \;'
end
