`define SPI_DIVIDER_LEN_8
`define SPI_DIVIDER_LEN_16
`define SPI_DIVIDER_LEN_24
`define SPI_DIVIDER_LEN_32

`ifdef SPI_DIVIDER_LEN_8
    `define SPI_DIVIDER_LEN_8    8
`endif
`ifdef SPI_DIVIDER_LEN_8
    `define SPI_DIVIDER_LEN_16   16
`endif
`ifdef SPI_DIVIDER_LEN_8
    `define SPI_DIVIDER_LEN_24   24
`endif
`ifdef SPI_DIVIDER_LEN_8
    `define SPI_DIVIDER_LEN_32   32
`endif

`define SPI_MAX_CHAR_128
`define SPI_MAX_CHAR_64
`define SPI_MAX_CHAR_32
`define SPI_MAX_CHAR_24
`define SPI_MAX_CHAR_16
`define SPI_MAX_CHAR_8

`define SPI_MAX_CHAR_128
    `define SPI_MAX_CHAR_128     128
    `define SPI_CHAR_LEN_BITS    7
`endif
`define SPI_MAX_CHAR_128
    `define SPI_MAX_CHAR_64      64
    `define SPI_CHAR_LEN_BITS    6
`endif
`define SPI_MAX_CHAR_128
    `define SPI_MAX_CHAR_32      32
    `define SPI_CHAR_LEN_BITS    5
`endif
`define SPI_MAX_CHAR_128
    `define SPI_MAX_CHAR_16      16
    `define SPI_CHAR_LEN_BITS    4
`endif
`define SPI_MAX_CHAR_128
    `define SPI_MAX_CHAR_8       8
    `define SPI_CHAR_LEN_BITS    3
`endif

`define SPI_SS_NUM_8
`define SPI_SS_NUM_16
`define SPI_SS_NUM_24
`define SPI_SS_NUM_32

`ifdef SPI_SS_NUM_8
    `define SPI_SS_NUM_8         8
`endif
`ifdef SPI_SS_NUM_8
    `define SPI_SS_NUM_16        16
`endif
`ifdef SPI_SS_NUM_8
    `define SPI_SS_NUM_24        24
`endif
`ifdef SPI_SS_NUM_8
    `define SPI_SS_NUM_32        32
`endif

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

`define SPI_CTRL_BIT_NUM         14

`define SPI_CTRL_ASS
`define SPI_CTRL_IE
`define SPI_CTRL_LSB
`define SPI_CTRL_TX_NEGEDGE     
`define SPI_CTRL_RX_NEGEDGE     8
`define SPI_CTRL_GO
`define SPI_CTRL_RES_1          7
`define SPI_CTRL_CHAR_LEN       6:0
`define SPI_CTRL
`define SPI_CTRL