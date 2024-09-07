# Simple-PC
This project aims to create a 12-bit simple computer. The project was done using _Quartus Prime Lite 20.1.1_

The project consists of following modules (the ticked ones have been completed):
- [x] CLA - 4-bit Carry Look Ahead adder
- [ ] ALU - 12-bit ALU
- [ ] Main PC Part
- [x] Binary to BCD converter
- [x] BCD 7 Segment Display

> [!NOTE]
> PS: The readme originally said 32-bit ALU, that was the aim. But I wanted to make it a bit more than that and to be so that I could implement it on the _DE2-115_ board I recently got for this year from the _Department of Electronics and Telecommunications Engineering - University of Moratuwa - Sri Lanka_

## Instructions
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
  
**Function Buttons:**
 
<table style="border-collapse: collapse; width: 100%;">
  <tr>
    <th>3</th>
    <th>2</th>
    <th>1</th>
    <th>0</th>
  </tr>
  <tr>
    <th><samp>N/A</samp></th>
    <th><samp>CLR</samp></th>
    <th><samp>STR</samp></th>
    <th><samp>ENT</samp></th>
  </tr>
</table>
