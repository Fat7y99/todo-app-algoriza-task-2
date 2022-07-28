abstract class TasksStates {}

class AppInitialState extends TasksStates {}

class InsertingTaskState extends TasksStates {}

class GettingTasksState extends TasksStates {}

class DeletingTaskState extends TasksStates {}

class UpdatingTaskState extends TasksStates {}

class AddingToFavouritesState extends TasksStates {}

class GettingUncompletedTasksState extends TasksStates {}

class GettingCompletedTasksState extends TasksStates {}

class GettingFavoriteTasksState extends TasksStates {}
