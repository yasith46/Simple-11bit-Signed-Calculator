# Simple-PC
This project aims to create a 11-bit simple computer. The project was done using _Quartus Prime Lite 20.1.1_

The project consists of following modules (the ticked ones have been completed):
- [x] CLA - 4-bit Carry Look Ahead adder
- [ ] ALU - 12-bit ALU
- [ ] Main PC Part
- [x] Binary to BCD converter
- [x] BCD 7 Segment Display

![WhatsApp Image 2024-09-08 at 23 58 06_81e6a666](https://github.com/user-attachments/assets/4c79b534-707f-4d50-9073-6826c14e7487)


> [!NOTE]
> PS: The readme originally said 32-bit ALU, that was the aim. But I wanted to make it a bit more than that and to be so that I could implement it on the _DE2-115_ board I recently got for this year from the _Department of Electronics and Telecommunications Engineering - University of Moratuwa - Sri Lanka_

## Instructions
> [!NOTE]
> PS: Please note that [15:14] of the instruction has been set as N/A only because the switches on my FPGA have developed too much rust and are stuck up there. You are free to use those bits as well (probably you don't have the same issue). I might change the instruction and the length if I come about a workaround for this which does not include meddling with the already existing switches (mind you the FPGA is not mine).

**Input configuration:**<br>
For input mode `CMD` <samp>= 3'b000</samp>

<table style="border-collapse: collapse; width: 100%;">
  <tr>
    <th>17</th>
    <th>16</th>
    <th>15</th>
    <th>14</th>
    <th>13</th>
    <th>12</th>
    <th>11</th>
    <th>10</th>
    <th>9</th>
    <th>8</th>
    <th>7</th>
    <th>6</th>
    <th>5</th>
    <th>4</th>
    <th>3</th>
    <th>2</th>
    <th>1</th>
    <th>0</th>
  </tr>
  <tr>
    <th colspan=2><samp>CMD<br>[2:1]</samp></th>
    <th colspan=2><samp>-- N/A --</samp></th>
    <th><samp>CMD<br>[0]</samp></th>
    <th colspan=2><samp>R0</samp></th>
    <th colspan=11><samp>IMMEDIATE</samp></th>
  </tr>
</table>


**Operation configuration:**<br>
For operation mode `CMD` <samp>!= 3'b000</samp>
<table style="border-collapse: collapse; width: 100%;">
  <tr>
    <th>17</th>
    <th>16</th>
    <th>15</th>
    <th>14</th>
    <th>13</th>
    <th>12</th>
    <th>11</th>
    <th>10</th>
    <th>9</th>
    <th>8</th>
    <th>7</th>
    <th>6</th>
    <th>5</th>
    <th>4</th>
    <th>3</th>
    <th>2</th>
    <th>1</th>
    <th>0</th>
  </tr>
  <tr>
    <th colspan=2><samp>CMD<br>[2:1]</samp></th>
    <th colspan=2><samp>-- N/A --</samp></th>
    <th><samp>CMD</samp><br>[0]</th>
    <th colspan=2><samp>R0</samp></th>
    <th colspan=2><samp>R2</samp></th>
    <th colspan=2><samp>R1</samp></th>
    <th colspan=7;"><samp>----------- VOID -----------</samp></th>
  </tr>
</table>

**Commands**
<table>
  <tr>
    <th>OPCODE</th>
    <th>CMD</th>
    <th>Description</th>
    <th>Status</th>
  </tr>
  <tr>
    <td><code>000</code></td>
    <td><code>Ld</code></td>
    <td>Loads the immediate to R0</td>
    <td> ✅ Works</td>
  </tr>
  
  <tr>
    <td><code>001</code></td>
    <td><code>Ad</code></td>
    <td>Add R1 and R2, save to R0</td>
    <td> ✅ Works</td>
  </tr>
  
  <tr>
    <td><code>010</code></td>
    <td><code>Su</code></td>
    <td>Substracts R2 from R1, saves to R0</td>
    <td> ✅ Works</td>
  </tr>
  
  <tr>
    <td><code>011</code></td>
    <td><code>An</code></td>
    <td>Bitwise AND between R2 from R1, saves to R0</td>
    <td> ✅ Works</td>
  </tr>
  
  <tr>
    <td><code>100</code></td>
    <td><code>Or</code></td>
    <td>Bitwise OR between R2 from R1, saves to R0</td>
    <td> ✅ Works</td>
  </tr>
  
  <tr>
    <td><code>101</code></td>
    <td><code>Sh</code></td>
    <td>Displays the number at R0 (for debugging purposes)</td>
    <td> ✅ Works</td>
  </tr>
</table>
  
**Function Buttons:**<br>
KEY0: `ENTER` <br>
KEY1: `CLR` (Temporarily deleted)
