import Foundation

struct ProjectTask: Searchable {
    var parameter: String {
        return "\(done)"
    }
    
    
    
    var project: Project
	var taskTitle: String = ""
	var commentForTask: String = ""
	var done: Bool = true
    
    init(from project: Project) {
        self.taskTitle = project.name
        self.commentForTask = project.dateTitle
        self.done = project.isEnded
        self.project = project
    }
}
