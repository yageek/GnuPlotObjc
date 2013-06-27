
namespace :test do
	task :build do	
		system("xctool -project GnuPlotObjc.xcodeproj -scheme GnuPlotObjc build")
	end
end

task :test => ['test:build']
