# Asynchronous-FIFO-Design
This repository contains the verilog implementation of Asynchronous FIFO

### Top level block diagarm of Asynchronous FIFO:
![Alt Text](assets/fifo_top.png)

### Gray counter: 
![Alt Text](assets/fifo_graycounter.png)

### Synchronizers for afull_n/aalmost_full_n and aempty_n/aempty_full_n signals: 
![Alt Text](assets/fifo_synchronizers.png)


## Simulation Results
### Test case 1:
Write data and read it back
![Alt Text](assets/fifo_test1.png)

### Test case 2:
Write data to make FIFO full and try to write more data
![Alt Text](assets/fifo_test2.png)

### Test case 3:
Read data from empty FIFO and try to read more data
![Alt Text](assets/fifo_test3.png)

### Test case 4:
Write 2 data and read 1 data
![Alt Text](assets/fifo_test4.png)

### Test case 5:
Write until fifo become full and then read until fifo become empty
![Alt Text](assets/fifo_test5.png)



## References
1. [Sunburst Design: Simulation and Synthesis Techniques for Asynchronous FIFO Design with Asynchronous Pointer Comparisons](http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO2.pdf)
2. [Sunburst Design: Simulation and Synthesis Techniques for Asynchronous FIFO Design](http://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf)
