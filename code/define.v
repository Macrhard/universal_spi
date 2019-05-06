//设置时钟分频数
`define SPI_DIVIDER_LEN_8 
//`define SPI_DIVIDER_LEN_16
//`define SPI_DIVIDER_LEN_24
//`define SPI_DIVIDER_LEN_32

`ifdef SPI_DIVIDER_LEN_8
    `define SPI_DIVIDER_LEN      8
`endif
`ifdef SPI_DIVIDER_LEN_16
    `define SPI_DIVIDER_LEN      16
`endif
`ifdef SPI_DIVIDER_LEN_24
    `define SPI_DIVIDER_LEN      24
`endif
`ifdef SPI_DIVIDER_LEN_32
    `define SPI_DIVIDER_LEN      32
`endif

///////////////////////////////////////////
//设置每次能够接收或者发送的最大位数
//`define SPI_MAX_CHAR_128
//`define SPI_MAX_CHAR_64
//`define SPI_MAX_CHAR_32
//`define SPI_MAX_CHAR_24
`define SPI_MAX_CHAR_16
//`define SPI_MAX_CHAR_8

`ifdef SPI_MAX_CHAR_128
    `define SPI_MAX_CHAR         128
    `define SPI_CHAR_LEN_BITS    7
`endif
`ifdef SPI_MAX_CHAR_64
    `define SPI_MAX_CHAR         64
    `define SPI_CHAR_LEN_BITS    6
`endif
`ifdef SPI_MAX_CHAR_32
    `define SPI_MAX_CHAR         32
    `define SPI_CHAR_LEN_BITS    5
`endif
`ifdef SPI_MAX_CHAR_24
    `define SPI_MAX_CHAR         24
    `define SPI_CHAR_LEN_BITS    5
`endif
`ifdef SPI_MAX_CHAR_16
    `define SPI_MAX_CHAR         16
    `define SPI_CHAR_LEN_BITS    4
`endif
`ifdef SPI_MAX_CHAR_8
    `define SPI_MAX_CHAR         8
    `define SPI_CHAR_LEN_BITS    3
`endif

/////////////////////////////////////////
//设置从机最大个数
/////////////////////////////////////////
`define SPI_SS_NUM_8
//`define SPI_SS_NUM_16
//`define SPI_SS_NUM_24
//`define SPI_SS_NUM_32

`ifdef SPI_SS_NUM_8
    `define SPI_SS_NUM           8
`endif
`ifdef SPI_SS_NUM_16
    `define SPI_SS_NUM           16
`endif
`ifdef SPI_SS_NUM_24
    `define SPI_SS_NUM           24
`endif
`ifdef SPI_SS_NUM_32
    `define SPI_SS_NUM           32
`endif

////////////////////////////////////////////
//WISHBONE 编址时，spi寄存器占据的位置
////////////////////////////////////////////
`define SPI_OFS_BITS             4:2

///////////////////////////////////////////
//地址编译时，寄存器分支对应的编码
///////////////////////////////////////////
`define SPI_TX_0                 0
`define SPI_TX_1                 1 
`define SPI_TX_2                 2 
`define SPI_TX_3                 3 
`define SPI_RX_0                 0
`define SPI_RX_1                 1 
`define SPI_RX_2                 2 
`define SPI_RX_3                 3 

`define SPI_CTRL                 4
`define SPI_DIVIDE               5
`define SPI_SS                   6

/////////////////////////////////////////
//控制寄存器的位数
/////////////////////////////////////////
`define SPI_CTRL_BIT_NUM         14

/////////////////////////////////////////
//控制字对应的控制寄存器的位置
////////////////////////////////////////
`define SPI_CTRL_ASS            13
`define SPI_CTRL_IE             12
`define SPI_CTRL_LSB            11
`define SPI_CTRL_TX_NEGEDGE     10   
`define SPI_CTRL_RX_NEGEDGE     9
`define SPI_CTRL_GO             8
`define SPI_CTRL_RES_1          7
`define SPI_CTRL_CHAR_LEN       6:0