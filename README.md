# DSE_LAB5
Lab sulle finite state machines.
## Task1
Implementata come vuole lui, i combinatorial circuits funzionano con dataflow, il reset è sincrono (applicato a cc1 viene letto dai ff al rising edge), 
N.B. il resetn dei FF è settato su '1' perché altrimenti lo stato A non si attiva mai, prima non mi funzionava la testbench per quello. I flipflops sono ottenuti con un for generate loop, siccome sono tutti molto simili.
## Task2
Questo è una variazione del primo esercizio, con la state table che descrive lui nell'assignment, in effetti facendo il primo in quel modo ottenere questa nuova FSM è abbastanza veloce. La differenza principale è che ora il reset è asincrono ed è applicato ai FF.
## Task 3
Fa la stessa cosa ma con l'enumerate, reset asincrono nel process dei fliflops.