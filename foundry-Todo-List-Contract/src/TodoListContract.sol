// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TodoListContract {
    enum Status { Incomplete, Complete }

    struct Task {
        string name;
        string description;
        Status status;
        uint256 deadline; // Stretch goal
    }

    // Per-user tasks only
    mapping(address => Task[]) private _userTasks;

    // Events
    event TaskAdded(address indexed user, uint256 taskId, string name);
    event TaskCompleted(address indexed user, uint256 taskId);

    function addTask(string memory _name, string memory _description, uint256 _deadline) public {
        _userTasks[msg.sender].push(Task({
            name: _name,
            description: _description,
            status: Status.Incomplete,
            deadline: _deadline
        }));
        emit TaskAdded(msg.sender, _userTasks[msg.sender].length - 1, _name);
    }

    function viewTask(uint256 _index) public view returns (Task memory) {
        require(_index < _userTasks[msg.sender].length, "Index out of bounds");
        return _userTasks[msg.sender][_index];
    }

    function markAsComplete(uint256 _index) public {
        require(_index < _userTasks[msg.sender].length, "Index out of bounds");
        _userTasks[msg.sender][_index].status = Status.Complete;
        emit TaskCompleted(msg.sender, _index);
    }

    // Stretch: Delete task (shift array elements)
    function deleteTask(uint256 _index) public {
        require(_index < _userTasks[msg.sender].length, "Index out of bounds");
        _userTasks[msg.sender][_index] = _userTasks[msg.sender][_userTasks[msg.sender].length - 1];
        _userTasks[msg.sender].pop();
    }
}