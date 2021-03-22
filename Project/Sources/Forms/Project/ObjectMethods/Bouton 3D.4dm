C_OBJECT:C1216($project)

projectList:=ds:C1482.Project.all()
$project:=ds:C1482.Project.new()
Default_project_name:="Project_"+String:C10(Current date:C33)
getLogLines($project)