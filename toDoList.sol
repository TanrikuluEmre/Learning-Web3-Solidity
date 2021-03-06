// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract toDoList{

    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public Todos;

    function create(string calldata _text) external {

        Todo memory x;
        x.text=_text;
        x.completed=false;
        Todos.push(x);
    } 

    function updateText(uint _index,string calldata _text) external {

        Todos[_index].text=_text;
    }

    function get(uint _index) external view returns(string memory,bool){
        Todo memory todoo = Todos[_index];
         
        return (todoo.text,todoo.completed);
    }
    function toggleCompleted(uint _index) external {
        Todos[_index].completed = !Todos[_index].completed;
    }

}