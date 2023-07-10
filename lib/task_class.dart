class Task{
  final String name;
  final DateTime dueDate;
  var status = 'New';

  Task(this.name,this.dueDate);

  void changeStatus(){
    if (status == 'New'){
      status = 'Working';
    }else if (status == 'Working'){
      status = 'Done';
    }else{
      status = 'New';
    }
  }
}