# 🛠️ Interrupt Handling in x86 Assembly
A low-level system programming project focused on **Hardware Interrupts** and System Calls using x86 Assembly Language.

---

### 📝 Project Description
This project demonstrates how a processor handles asynchronous events via **Interrupts**. It involves writing custom interrupt service routines (ISRs) and understanding the communication between hardware and software.

### 🚀 Key Learning Objectives
- **IVT (Interrupt Vector Table):** Understanding how addresses of ISRs are stored.
- **ISR (Interrupt Service Routine):** Developing custom handlers for specific hardware triggers.
- **Hardware Interaction:** Directly interacting with the CPU registers (AX, BX, CX, DX).
- **Stack Operations:** Managing the stack during interrupt calls to ensure system stability.

### 🏗️ Technical Details
- **Architecture:** x86 (8086)
- **Assembler:** NASM / MASM (Jo aapne use kiya)
- **Environment:** DOSBox / Emulator 8086

### 🛠️ Concepts Implemented
- Hooking custom interrupts.
- Saving and restoring processor state (Flags, CS, IP).
- Handling keyboard or timer interrupts (Specify if you used a specific one).

### 🎮 How to Run (using DOSBox)

```bash
# 1. Mount your directory in DOSBox
mount c C:\AssemblyProjects

# 2. Assemble the file
nasm -f bin project.asm -o project.com

# 3. Execute
project.com
