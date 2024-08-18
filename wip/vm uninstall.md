제공된 검색 결과를 바탕으로 Vagrant에서 잠긴 기계를 잠금 해제하는 단계는 다음과 같습니다.
호스트 시스템을 재부팅하여 가상 시스템에서 보류 중인 잠금을 제거합니다. 이는 기존 잠금을 ​​지우는 데 도움이 될 수 있습니다.
시스템의 VirtualBox VM 폴더에서 VM 디렉터리를 수동으로 제거합니다. 디렉토리 이름은 다음과 같습니다 .firstvagrant_node2_1714537166783_19194
VBoxManage 명령을 사용하여 비상 정지 모드에서 VM을 시작하여 잠금을 해제합니다.
VBoxManage startvm <vm-uuid> --type emergencystop

를 실행하여 찾을 수 있는 잠긴 VM의 UUID로 바꿉니다 .<vm-uuid>VBoxManage list vms
VM의 잠금이 해제되면 다음 명령을 사용하여 제거할 수 있습니다.
VBoxManage unregistervm --delete <vm-uuid>

또는 이미 VM 파일을 삭제한 경우:
VBoxManage unregistervm <vm-uuid>

다음 단계를 수행하면 잠긴 Vagrant 머신의 잠금을 해제한 다음 필요에 따라 머신을 파괴하거나 관리할 수 있습니다.

first vagrant vagrant destroy -f
==> node2: Destroying VM and associated drives...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["unregistervm", "c144dc32-0b34-442a-a1ed-a7755e6def18", "--delete"]

Stderr: VBoxManage: error: Cannot unregister the machine 'firstvagrant_node2_1714537166783_19194' while it is locked
VBoxManage: error: Details: code VBOX_E_INVALID_OBJECT_STATE (0x80bb0007), component MachineWrap, interface IMachine, callee nsISupports
VBoxManage: error: Context: "Unregister(fDeleteAll ? CleanupMode_DetachAllReturnHardDisksAndVMRemovable :CleanupMode_DetachAllReturnHardDisksOnly, ComSafeArrayAsOutParam(aMedia))" at line 236 of file VBoxManageMisc.cpp

➜ first vagrant VBoxManage unregistervm c144dc32-0b34-442a-a1ed-a7755e6def18 --delete
VBoxManage: error: Cannot unregister the machine 'firstvagrant_node2_1714537166783_19194' while it is locked
VBoxManage: error: Details: code VBOX_E_INVALID_OBJECT_STATE (0x80bb0007), component MachineWrap, interface IMachine, callee nsISupports
VBoxManage: error: Context: "Unregister(fDeleteAll ? CleanupMode_DetachAllReturnHardDisksAndVMRemovable :CleanupMode_DetachAllReturnHardDisksOnly, ComSafeArrayAsOutParam(aMedia))" at line 236 of file VBoxManageMisc.cpp
➜ first vagrant VBoxManage startvm c144dc32-0b34-442a-a1ed-a7755e6def18 --delete  
Oracle VM VirtualBox Command Line Management Interface Version 7.0.14
Copyright (C) 2005-2024 Oracle and/or its affiliates

VBoxManage: error: unknown option: --delete

Usage - Start a virtual machine:

VBoxManage startvm <uuid | vmname...> [--putenv=name[=value]] [--type= [gui | headless | sdl | separate] ] --password file
--password-id password identifier

➜ first vagrant VBoxManage startvm c144dc32-0b34-442a-a1ed-a7755e6def18 --type emergencystop
➜ first vagrant VBoxManage startvm c144dc32-0b34-442a-a1ed-a7755e6def18 --delete

Oracle VM VirtualBox Command Line Management Interface Version 7.0.14
Copyright (C) 2005-2024 Oracle and/or its affiliates

VBoxManage: error: unknown option: --delete

Usage - Start a virtual machine:

VBoxManage startvm <uuid | vmname...> [--putenv=name[=value]] [--type= [gui | headless | sdl | separate] ] --password file
--password-id password identifier
➜ first vagrant VBoxManage unregistervm c144dc32-0b34-442a-a1ed-a7755e6def18 --delete
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
➜ first vagrant vagrant destroy -f  
==> node2: VM not created. Moving on...
==> node1: Destroying VM and associated drives...
==> master: Destroying VM and associated drives...
