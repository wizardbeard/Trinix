module TaskManager.Process;

import VFSManager.VFS;
import VFSManager.FSNode;
import VFSManager.DirectoryNode;
import SyscallManager.Resource;
import TaskManager.Task;
import TaskManager.Thread;
import TaskManager.Signal;
import Architectures.Paging;
import Core.DeviceManager;

import System.Collections.Generic.All;


class Process /*: Resource */{
private:
	this() {/*super(0, null);*/ }

package:
	ulong id; //unique ID for each process
	Process parent;
	State state;
	uint mask;

	string name;
	string description;
	string[] cmdline;
	ulong uid;

	DirectoryNode cwd;
	Paging paging;
	List!Thread threads;
	List!FSNode descriptors;

	void function() signals[Signal.Count];
	public List!SignalTable signalQueue;
	ulong* signalStack;


public:
	enum State : ubyte {
		Zombie,
		Running,
		Stopped
	}

	
	DirectoryNode GetCWD() { return cwd; }
	void SetCWD(DirectoryNode value) { cwd = value; }

	void RegisterFD(FSNode fd) { descriptors.Add(fd); }
	void UnregisterFD(FSNode fd) { descriptors.Remove(fd); }


	static Process Init() {
		if (Task.Threads.Count)
			return null;

		Process ret     = new Process();
		ret.id          = Task.NewPID();
		ret.name        = "Init";
		ret.description = "Shit happens...";
		ret.mask        = 0x12; //022 in oct
		ret.paging      = Paging.KernelPaging;
		ret.cwd         = VFS.RootNode;

		ret.descriptors = new List!FSNode();
		ret.threads     = new List!Thread();
		ret.signalQueue = new List!SignalTable();


		ret.descriptors.Add(DeviceManager.DevFS.Childrens[0]); //keyboard stdin

		Thread t = new Thread();
		t.parent = ret;
		t.state = Thread.State.Running;
		t.kernelStack = (new ulong[Thread.STACK_SIZE]).ptr;
		t.SetKernelStack();
		ret.threads.Add(t);

		Task.Procs.Add(ret);
		Task.Threads.Add(t);

		return ret;
	}





//Syscalls
//	override bool Accesible() { return true; }
}