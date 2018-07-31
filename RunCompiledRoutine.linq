<Query Kind="Program">
  <NuGetReference>IronPython</NuGetReference>
  <NuGetReference>Newtonsoft.Json</NuGetReference>
  <Namespace>IronPython.Hosting</Namespace>
  <Namespace>Microsoft.Scripting.Hosting</Namespace>
  <Namespace>Newtonsoft.Json.Serialization</Namespace>
  <Namespace>Newtonsoft.Json</Namespace>
</Query>

void Main(string[] args)
{
	var pathToPythonDll = args[0];

	$"Running {pathToPythonDll}".Dump();

	// Change working directory, so it doesn't try to import from our original .py files
	Directory.SetCurrentDirectory(@"C:\");

	var scriptEngine = Python.CreateEngine();
	scriptEngine.Runtime.LoadAssembly(Assembly.LoadFile(pathToPythonDll));
	var scope = scriptEngine.ImportModule("TestScript");
//	scriptEngine.GetModuleFilenames().Dump();
	dynamic mainFunc = scope.GetVariable("main");
	mainFunc();
}
