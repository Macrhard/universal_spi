//==================================================================
// Copyright (C) 2019 StarBlaze LTD
// Author      : RegGenerater
// Create Date : 2019/2/25 10:25:53
// File Name   : drx0.v
// Log         : 
//==================================================================


module DRX0_REGS (
input                     clk,
input                     rst_n,
input                     reg_cs,
input                     rd_en,
input                     wr_en,
input             [15:0]  addr,
input             [31:0]  wdata,
output            [15:0]  o_prog_coff0,
output            [15:0]  o_prog_coff1,
output            [15:0]  o_prog_coff2,
output            [15:0]  o_prog_coff3,
output            [15:0]  o_prog_coff4,
output            [15:0]  o_prog_coff5,
output            [15:0]  o_prog_coff6,
output            [15:0]  o_prog_coff7,
output            [15:0]  o_prog_coff8,
output            [15:0]  o_prog_coff9,
output            [15:0]  o_prog_coff10,
output            [15:0]  o_prog_coff11,
output            [15:0]  o_prog_coff12,
output            [15:0]  o_prog_coff13,
output            [15:0]  o_prog_coff14,
output            [15:0]  o_prog_coff15,
output            [15:0]  o_prog_coff16,
output            [15:0]  o_prog_coff17,
output            [15:0]  o_prog_coff18,
output            [15:0]  o_prog_coff19,
output            [15:0]  o_prog_coff20,
output            [15:0]  o_prog_coff21,
output            [15:0]  o_prog_coff22,
output            [15:0]  o_prog_coff23,
output            [15:0]  o_prog_coff24,
output            [15:0]  o_prog_coff25,
output            [15:0]  o_prog_coff26,
output            [15:0]  o_prog_coff27,
output            [15:0]  o_prog_coff28,
output            [15:0]  o_prog_coff29,
output            [15:0]  o_prog_coff30,
output            [15:0]  o_prog_coff31,
output            [15:0]  o_prog_coff32,
output            [15:0]  o_prog_coff33,
output            [15:0]  o_prog_coff34,
output            [15:0]  o_prog_coff35,
output            [15:0]  o_prog_coff36,
output            [15:0]  o_prog_coff37,
output            [15:0]  o_prog_coff38,
output            [15:0]  o_prog_coff39,
output            [15:0]  o_prog_coff40,
output            [15:0]  o_prog_coff41,
output            [15:0]  o_prog_coff42,
output            [15:0]  o_prog_coff43,
output            [15:0]  o_prog_coff44,
output            [15:0]  o_prog_coff45,
output            [15:0]  o_prog_coff46,
output            [15:0]  o_prog_coff47,
output            [15:0]  o_prog_coff48,
output            [15:0]  o_prog_coff49,
output            [15:0]  o_prog_coff50,
output            [15:0]  o_prog_coff51,
output            [15:0]  o_prog_coff52,
output            [15:0]  o_prog_coff53,
output            [15:0]  o_prog_coff54,
output            [15:0]  o_prog_coff55,
output            [15:0]  o_prog_coff56,
output            [15:0]  o_prog_coff57,
output            [15:0]  o_prog_coff58,
output            [15:0]  o_prog_coff59,
output            [15:0]  o_prog_coff60,
output            [15:0]  o_prog_coff61,
output            [15:0]  o_prog_coff62,
output            [15:0]  o_prog_coff63,
output            [10:0]  o_clk_gate,
output                    o_iq_switch,
output                    o_sw_reset,
output                    o_dgc_bypass,
output                    o_notch_en,
output             [2:0]  o_notch_bypass,
output                    o_mix_bypass,
output                    o_mix_enable,
output                    o_hbf3_bypass,
output                    o_hbf2_bypass,
output             [3:0]  o_hbf_band_sel,
output                    o_bypass_dc_est,
output                    o_bypass_hbf,
output             [1:0]  o_cic_mode,
output                    o_hbf1_bypass,
output             [4:0]  o_prog_clk_gen,
output             [3:0]  o_prog_clk_mod,
output                    o_prog_bypass,
output             [2:0]  o_prog_dec_mode_l,
output             [2:0]  o_prog_dec_mode_h,
output            [31:0]  o_nco_phase_init_l,
output             [6:0]  o_nco_phase_init_h,
output            [31:0]  o_nco_phase_inc_l,
output             [6:0]  o_nco_phase_inc_h,
output             [7:0]  o_dgc_gain,
output            [31:0]  o_notch_fcos_l,
output            [27:0]  o_notch_fcos_h,
output            [31:0]  o_notch_fsin_l,
output            [27:0]  o_notch_fsin_h,
output             [3:0]  o_notch_type0_t2,
output             [3:0]  o_notch_type0_t1,
output             [3:0]  o_notch_type0_t0,
output             [3:0]  o_notch_type0_k3,
output             [3:0]  o_notch_type0_k2,
output             [3:0]  o_notch_type0_k1,
output             [3:0]  o_notch_type0_k0,
output             [3:0]  o_notch_type1_t2,
output             [3:0]  o_notch_type1_t1,
output             [3:0]  o_notch_type1_t0,
output             [3:0]  o_notch_type1_k3,
output             [3:0]  o_notch_type1_k2,
output             [3:0]  o_notch_type1_k1,
output             [3:0]  o_notch_type1_k0,
output reg        [31:0]  dataout
);
//-------------------------------------------
// Wires
wire                    wen_h0000;
wire             [15:0] rw_reg_h0000;
wire                    wen_h0004;
wire             [15:0] rw_reg_h0004;
wire                    wen_h0008;
wire             [15:0] rw_reg_h0008;
wire                    wen_h000C;
wire             [15:0] rw_reg_h000C;
wire                    wen_h0010;
wire             [15:0] rw_reg_h0010;
wire                    wen_h0014;
wire             [15:0] rw_reg_h0014;
wire                    wen_h0018;
wire             [15:0] rw_reg_h0018;
wire                    wen_h001C;
wire             [15:0] rw_reg_h001C;
wire                    wen_h0020;
wire             [15:0] rw_reg_h0020;
wire                    wen_h0024;
wire             [15:0] rw_reg_h0024;
wire                    wen_h0028;
wire             [15:0] rw_reg_h0028;
wire                    wen_h002C;
wire             [15:0] rw_reg_h002C;
wire                    wen_h0030;
wire             [15:0] rw_reg_h0030;
wire                    wen_h0034;
wire             [15:0] rw_reg_h0034;
wire                    wen_h0038;
wire             [15:0] rw_reg_h0038;
wire                    wen_h003C;
wire             [15:0] rw_reg_h003C;
wire                    wen_h0040;
wire             [15:0] rw_reg_h0040;
wire                    wen_h0044;
wire             [15:0] rw_reg_h0044;
wire                    wen_h0048;
wire             [15:0] rw_reg_h0048;
wire                    wen_h004C;
wire             [15:0] rw_reg_h004C;
wire                    wen_h0050;
wire             [15:0] rw_reg_h0050;
wire                    wen_h0054;
wire             [15:0] rw_reg_h0054;
wire                    wen_h0058;
wire             [15:0] rw_reg_h0058;
wire                    wen_h005C;
wire             [15:0] rw_reg_h005C;
wire                    wen_h0060;
wire             [15:0] rw_reg_h0060;
wire                    wen_h0064;
wire             [15:0] rw_reg_h0064;
wire                    wen_h0068;
wire             [15:0] rw_reg_h0068;
wire                    wen_h006C;
wire             [15:0] rw_reg_h006C;
wire                    wen_h0070;
wire             [15:0] rw_reg_h0070;
wire                    wen_h0074;
wire             [15:0] rw_reg_h0074;
wire                    wen_h0078;
wire             [15:0] rw_reg_h0078;
wire                    wen_h007C;
wire             [15:0] rw_reg_h007C;
wire                    wen_h0080;
wire             [15:0] rw_reg_h0080;
wire                    wen_h0084;
wire             [15:0] rw_reg_h0084;
wire                    wen_h0088;
wire             [15:0] rw_reg_h0088;
wire                    wen_h008C;
wire             [15:0] rw_reg_h008C;
wire                    wen_h0090;
wire             [15:0] rw_reg_h0090;
wire                    wen_h0094;
wire             [15:0] rw_reg_h0094;
wire                    wen_h0098;
wire             [15:0] rw_reg_h0098;
wire                    wen_h009C;
wire             [15:0] rw_reg_h009C;
wire                    wen_h00A0;
wire             [15:0] rw_reg_h00A0;
wire                    wen_h00A4;
wire             [15:0] rw_reg_h00A4;
wire                    wen_h00A8;
wire             [15:0] rw_reg_h00A8;
wire                    wen_h00AC;
wire             [15:0] rw_reg_h00AC;
wire                    wen_h00B0;
wire             [15:0] rw_reg_h00B0;
wire                    wen_h00B4;
wire             [15:0] rw_reg_h00B4;
wire                    wen_h00B8;
wire             [15:0] rw_reg_h00B8;
wire                    wen_h00BC;
wire             [15:0] rw_reg_h00BC;
wire                    wen_h00C0;
wire             [15:0] rw_reg_h00C0;
wire                    wen_h00C4;
wire             [15:0] rw_reg_h00C4;
wire                    wen_h00C8;
wire             [15:0] rw_reg_h00C8;
wire                    wen_h00CC;
wire             [15:0] rw_reg_h00CC;
wire                    wen_h00D0;
wire             [15:0] rw_reg_h00D0;
wire                    wen_h00D4;
wire             [15:0] rw_reg_h00D4;
wire                    wen_h00D8;
wire             [15:0] rw_reg_h00D8;
wire                    wen_h00DC;
wire             [15:0] rw_reg_h00DC;
wire                    wen_h00E0;
wire             [15:0] rw_reg_h00E0;
wire                    wen_h00E4;
wire             [15:0] rw_reg_h00E4;
wire                    wen_h00E8;
wire             [15:0] rw_reg_h00E8;
wire                    wen_h00EC;
wire             [15:0] rw_reg_h00EC;
wire                    wen_h00F0;
wire             [15:0] rw_reg_h00F0;
wire                    wen_h00F4;
wire             [15:0] rw_reg_h00F4;
wire                    wen_h00F8;
wire             [15:0] rw_reg_h00F8;
wire                    wen_h00FC;
wire             [15:0] rw_reg_h00FC;
wire                    wen_h0100;
wire             [12:0] rw_reg_h0100;
wire                    wen_h0104;
wire             [30:0] rw_reg_h0104;
wire                    wen_h0108;
wire              [2:0] rw_reg_h0108;
wire                    wen_h010C;
wire             [31:0] rw_reg_h010C;
wire                    wen_h0110;
wire              [6:0] rw_reg_h0110;
wire                    wen_h0114;
wire             [31:0] rw_reg_h0114;
wire                    wen_h0118;
wire              [6:0] rw_reg_h0118;
wire                    wen_h011C;
wire              [7:0] rw_reg_h011C;
wire                    wen_h0120;
wire             [31:0] rw_reg_h0120;
wire                    wen_h0124;
wire             [27:0] rw_reg_h0124;
wire                    wen_h0128;
wire             [31:0] rw_reg_h0128;
wire                    wen_h012C;
wire             [27:0] rw_reg_h012C;
wire                    wen_h0130;
wire             [27:0] rw_reg_h0130;
wire                    wen_h0134;
wire             [27:0] rw_reg_h0134;
//------------------------------------------------------------
// 0X0000
//------------------------------------------------------------
assign wen_h0000 = wr_en & reg_cs & (addr == 16'h0000);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0000(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0000),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0000 )
    );
assign o_prog_coff0         = rw_reg_h0000[15:0];

//------------------------------------------------------------
// 0X0004
//------------------------------------------------------------
assign wen_h0004 = wr_en & reg_cs & (addr == 16'h0004);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0004(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0004),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0004 )
    );
assign o_prog_coff1         = rw_reg_h0004[15:0];

//------------------------------------------------------------
// 0X0008
//------------------------------------------------------------
assign wen_h0008 = wr_en & reg_cs & (addr == 16'h0008);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0008(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0008),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0008 )
    );
assign o_prog_coff2         = rw_reg_h0008[15:0];

//------------------------------------------------------------
// 0X000C
//------------------------------------------------------------
assign wen_h000C = wr_en & reg_cs & (addr == 16'h000C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H000C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h000C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h000C )
    );
assign o_prog_coff3         = rw_reg_h000C[15:0];

//------------------------------------------------------------
// 0X0010
//------------------------------------------------------------
assign wen_h0010 = wr_en & reg_cs & (addr == 16'h0010);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0010(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0010),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0010 )
    );
assign o_prog_coff4         = rw_reg_h0010[15:0];

//------------------------------------------------------------
// 0X0014
//------------------------------------------------------------
assign wen_h0014 = wr_en & reg_cs & (addr == 16'h0014);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0014(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0014),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0014 )
    );
assign o_prog_coff5         = rw_reg_h0014[15:0];

//------------------------------------------------------------
// 0X0018
//------------------------------------------------------------
assign wen_h0018 = wr_en & reg_cs & (addr == 16'h0018);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0018(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0018),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0018 )
    );
assign o_prog_coff6         = rw_reg_h0018[15:0];

//------------------------------------------------------------
// 0X001C
//------------------------------------------------------------
assign wen_h001C = wr_en & reg_cs & (addr == 16'h001C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H001C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h001C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h001C )
    );
assign o_prog_coff7         = rw_reg_h001C[15:0];

//------------------------------------------------------------
// 0X0020
//------------------------------------------------------------
assign wen_h0020 = wr_en & reg_cs & (addr == 16'h0020);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0020(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0020),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0020 )
    );
assign o_prog_coff8         = rw_reg_h0020[15:0];

//------------------------------------------------------------
// 0X0024
//------------------------------------------------------------
assign wen_h0024 = wr_en & reg_cs & (addr == 16'h0024);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0024(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0024),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0024 )
    );
assign o_prog_coff9         = rw_reg_h0024[15:0];

//------------------------------------------------------------
// 0X0028
//------------------------------------------------------------
assign wen_h0028 = wr_en & reg_cs & (addr == 16'h0028);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0028(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0028),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0028 )
    );
assign o_prog_coff10        = rw_reg_h0028[15:0];

//------------------------------------------------------------
// 0X002C
//------------------------------------------------------------
assign wen_h002C = wr_en & reg_cs & (addr == 16'h002C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H002C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h002C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h002C )
    );
assign o_prog_coff11        = rw_reg_h002C[15:0];

//------------------------------------------------------------
// 0X0030
//------------------------------------------------------------
assign wen_h0030 = wr_en & reg_cs & (addr == 16'h0030);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0030(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0030),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0030 )
    );
assign o_prog_coff12        = rw_reg_h0030[15:0];

//------------------------------------------------------------
// 0X0034
//------------------------------------------------------------
assign wen_h0034 = wr_en & reg_cs & (addr == 16'h0034);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0034(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0034),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0034 )
    );
assign o_prog_coff13        = rw_reg_h0034[15:0];

//------------------------------------------------------------
// 0X0038
//------------------------------------------------------------
assign wen_h0038 = wr_en & reg_cs & (addr == 16'h0038);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0038(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0038),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0038 )
    );
assign o_prog_coff14        = rw_reg_h0038[15:0];

//------------------------------------------------------------
// 0X003C
//------------------------------------------------------------
assign wen_h003C = wr_en & reg_cs & (addr == 16'h003C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H003C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h003C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h003C )
    );
assign o_prog_coff15        = rw_reg_h003C[15:0];

//------------------------------------------------------------
// 0X0040
//------------------------------------------------------------
assign wen_h0040 = wr_en & reg_cs & (addr == 16'h0040);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0040(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0040),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0040 )
    );
assign o_prog_coff16        = rw_reg_h0040[15:0];

//------------------------------------------------------------
// 0X0044
//------------------------------------------------------------
assign wen_h0044 = wr_en & reg_cs & (addr == 16'h0044);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0044(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0044),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0044 )
    );
assign o_prog_coff17        = rw_reg_h0044[15:0];

//------------------------------------------------------------
// 0X0048
//------------------------------------------------------------
assign wen_h0048 = wr_en & reg_cs & (addr == 16'h0048);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0048(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0048),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0048 )
    );
assign o_prog_coff18        = rw_reg_h0048[15:0];

//------------------------------------------------------------
// 0X004C
//------------------------------------------------------------
assign wen_h004C = wr_en & reg_cs & (addr == 16'h004C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H004C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h004C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h004C )
    );
assign o_prog_coff19        = rw_reg_h004C[15:0];

//------------------------------------------------------------
// 0X0050
//------------------------------------------------------------
assign wen_h0050 = wr_en & reg_cs & (addr == 16'h0050);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0050(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0050),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0050 )
    );
assign o_prog_coff20        = rw_reg_h0050[15:0];

//------------------------------------------------------------
// 0X0054
//------------------------------------------------------------
assign wen_h0054 = wr_en & reg_cs & (addr == 16'h0054);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0054(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0054),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0054 )
    );
assign o_prog_coff21        = rw_reg_h0054[15:0];

//------------------------------------------------------------
// 0X0058
//------------------------------------------------------------
assign wen_h0058 = wr_en & reg_cs & (addr == 16'h0058);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0058(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0058),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0058 )
    );
assign o_prog_coff22        = rw_reg_h0058[15:0];

//------------------------------------------------------------
// 0X005C
//------------------------------------------------------------
assign wen_h005C = wr_en & reg_cs & (addr == 16'h005C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H005C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h005C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h005C )
    );
assign o_prog_coff23        = rw_reg_h005C[15:0];

//------------------------------------------------------------
// 0X0060
//------------------------------------------------------------
assign wen_h0060 = wr_en & reg_cs & (addr == 16'h0060);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0060(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0060),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0060 )
    );
assign o_prog_coff24        = rw_reg_h0060[15:0];

//------------------------------------------------------------
// 0X0064
//------------------------------------------------------------
assign wen_h0064 = wr_en & reg_cs & (addr == 16'h0064);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0064(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0064),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0064 )
    );
assign o_prog_coff25        = rw_reg_h0064[15:0];

//------------------------------------------------------------
// 0X0068
//------------------------------------------------------------
assign wen_h0068 = wr_en & reg_cs & (addr == 16'h0068);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0068(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0068),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0068 )
    );
assign o_prog_coff26        = rw_reg_h0068[15:0];

//------------------------------------------------------------
// 0X006C
//------------------------------------------------------------
assign wen_h006C = wr_en & reg_cs & (addr == 16'h006C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H006C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h006C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h006C )
    );
assign o_prog_coff27        = rw_reg_h006C[15:0];

//------------------------------------------------------------
// 0X0070
//------------------------------------------------------------
assign wen_h0070 = wr_en & reg_cs & (addr == 16'h0070);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0070(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0070),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0070 )
    );
assign o_prog_coff28        = rw_reg_h0070[15:0];

//------------------------------------------------------------
// 0X0074
//------------------------------------------------------------
assign wen_h0074 = wr_en & reg_cs & (addr == 16'h0074);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0074(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0074),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0074 )
    );
assign o_prog_coff29        = rw_reg_h0074[15:0];

//------------------------------------------------------------
// 0X0078
//------------------------------------------------------------
assign wen_h0078 = wr_en & reg_cs & (addr == 16'h0078);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0078(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0078),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0078 )
    );
assign o_prog_coff30        = rw_reg_h0078[15:0];

//------------------------------------------------------------
// 0X007C
//------------------------------------------------------------
assign wen_h007C = wr_en & reg_cs & (addr == 16'h007C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H007C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h007C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h007C )
    );
assign o_prog_coff31        = rw_reg_h007C[15:0];

//------------------------------------------------------------
// 0X0080
//------------------------------------------------------------
assign wen_h0080 = wr_en & reg_cs & (addr == 16'h0080);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0080(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0080),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0080 )
    );
assign o_prog_coff32        = rw_reg_h0080[15:0];

//------------------------------------------------------------
// 0X0084
//------------------------------------------------------------
assign wen_h0084 = wr_en & reg_cs & (addr == 16'h0084);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0084(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0084),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0084 )
    );
assign o_prog_coff33        = rw_reg_h0084[15:0];

//------------------------------------------------------------
// 0X0088
//------------------------------------------------------------
assign wen_h0088 = wr_en & reg_cs & (addr == 16'h0088);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0088(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0088),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0088 )
    );
assign o_prog_coff34        = rw_reg_h0088[15:0];

//------------------------------------------------------------
// 0X008C
//------------------------------------------------------------
assign wen_h008C = wr_en & reg_cs & (addr == 16'h008C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H008C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h008C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h008C )
    );
assign o_prog_coff35        = rw_reg_h008C[15:0];

//------------------------------------------------------------
// 0X0090
//------------------------------------------------------------
assign wen_h0090 = wr_en & reg_cs & (addr == 16'h0090);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0090(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0090),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0090 )
    );
assign o_prog_coff36        = rw_reg_h0090[15:0];

//------------------------------------------------------------
// 0X0094
//------------------------------------------------------------
assign wen_h0094 = wr_en & reg_cs & (addr == 16'h0094);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0094(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0094),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0094 )
    );
assign o_prog_coff37        = rw_reg_h0094[15:0];

//------------------------------------------------------------
// 0X0098
//------------------------------------------------------------
assign wen_h0098 = wr_en & reg_cs & (addr == 16'h0098);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H0098(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0098),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h0098 )
    );
assign o_prog_coff38        = rw_reg_h0098[15:0];

//------------------------------------------------------------
// 0X009C
//------------------------------------------------------------
assign wen_h009C = wr_en & reg_cs & (addr == 16'h009C);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H009C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h009C),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h009C )
    );
assign o_prog_coff39        = rw_reg_h009C[15:0];

//------------------------------------------------------------
// 0X00A0
//------------------------------------------------------------
assign wen_h00A0 = wr_en & reg_cs & (addr == 16'h00A0);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00A0(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00A0),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00A0 )
    );
assign o_prog_coff40        = rw_reg_h00A0[15:0];

//------------------------------------------------------------
// 0X00A4
//------------------------------------------------------------
assign wen_h00A4 = wr_en & reg_cs & (addr == 16'h00A4);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00A4(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00A4),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00A4 )
    );
assign o_prog_coff41        = rw_reg_h00A4[15:0];

//------------------------------------------------------------
// 0X00A8
//------------------------------------------------------------
assign wen_h00A8 = wr_en & reg_cs & (addr == 16'h00A8);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00A8(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00A8),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00A8 )
    );
assign o_prog_coff42        = rw_reg_h00A8[15:0];

//------------------------------------------------------------
// 0X00AC
//------------------------------------------------------------
assign wen_h00AC = wr_en & reg_cs & (addr == 16'h00AC);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00AC(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00AC),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00AC )
    );
assign o_prog_coff43        = rw_reg_h00AC[15:0];

//------------------------------------------------------------
// 0X00B0
//------------------------------------------------------------
assign wen_h00B0 = wr_en & reg_cs & (addr == 16'h00B0);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00B0(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00B0),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00B0 )
    );
assign o_prog_coff44        = rw_reg_h00B0[15:0];

//------------------------------------------------------------
// 0X00B4
//------------------------------------------------------------
assign wen_h00B4 = wr_en & reg_cs & (addr == 16'h00B4);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00B4(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00B4),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00B4 )
    );
assign o_prog_coff45        = rw_reg_h00B4[15:0];

//------------------------------------------------------------
// 0X00B8
//------------------------------------------------------------
assign wen_h00B8 = wr_en & reg_cs & (addr == 16'h00B8);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00B8(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00B8),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00B8 )
    );
assign o_prog_coff46        = rw_reg_h00B8[15:0];

//------------------------------------------------------------
// 0X00BC
//------------------------------------------------------------
assign wen_h00BC = wr_en & reg_cs & (addr == 16'h00BC);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00BC(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00BC),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00BC )
    );
assign o_prog_coff47        = rw_reg_h00BC[15:0];

//------------------------------------------------------------
// 0X00C0
//------------------------------------------------------------
assign wen_h00C0 = wr_en & reg_cs & (addr == 16'h00C0);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00C0(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00C0),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00C0 )
    );
assign o_prog_coff48        = rw_reg_h00C0[15:0];

//------------------------------------------------------------
// 0X00C4
//------------------------------------------------------------
assign wen_h00C4 = wr_en & reg_cs & (addr == 16'h00C4);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00C4(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00C4),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00C4 )
    );
assign o_prog_coff49        = rw_reg_h00C4[15:0];

//------------------------------------------------------------
// 0X00C8
//------------------------------------------------------------
assign wen_h00C8 = wr_en & reg_cs & (addr == 16'h00C8);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00C8(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00C8),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00C8 )
    );
assign o_prog_coff50        = rw_reg_h00C8[15:0];

//------------------------------------------------------------
// 0X00CC
//------------------------------------------------------------
assign wen_h00CC = wr_en & reg_cs & (addr == 16'h00CC);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00CC(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00CC),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00CC )
    );
assign o_prog_coff51        = rw_reg_h00CC[15:0];

//------------------------------------------------------------
// 0X00D0
//------------------------------------------------------------
assign wen_h00D0 = wr_en & reg_cs & (addr == 16'h00D0);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00D0(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00D0),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00D0 )
    );
assign o_prog_coff52        = rw_reg_h00D0[15:0];

//------------------------------------------------------------
// 0X00D4
//------------------------------------------------------------
assign wen_h00D4 = wr_en & reg_cs & (addr == 16'h00D4);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00D4(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00D4),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00D4 )
    );
assign o_prog_coff53        = rw_reg_h00D4[15:0];

//------------------------------------------------------------
// 0X00D8
//------------------------------------------------------------
assign wen_h00D8 = wr_en & reg_cs & (addr == 16'h00D8);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00D8(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00D8),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00D8 )
    );
assign o_prog_coff54        = rw_reg_h00D8[15:0];

//------------------------------------------------------------
// 0X00DC
//------------------------------------------------------------
assign wen_h00DC = wr_en & reg_cs & (addr == 16'h00DC);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00DC(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00DC),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00DC )
    );
assign o_prog_coff55        = rw_reg_h00DC[15:0];

//------------------------------------------------------------
// 0X00E0
//------------------------------------------------------------
assign wen_h00E0 = wr_en & reg_cs & (addr == 16'h00E0);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00E0(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00E0),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00E0 )
    );
assign o_prog_coff56        = rw_reg_h00E0[15:0];

//------------------------------------------------------------
// 0X00E4
//------------------------------------------------------------
assign wen_h00E4 = wr_en & reg_cs & (addr == 16'h00E4);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00E4(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00E4),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00E4 )
    );
assign o_prog_coff57        = rw_reg_h00E4[15:0];

//------------------------------------------------------------
// 0X00E8
//------------------------------------------------------------
assign wen_h00E8 = wr_en & reg_cs & (addr == 16'h00E8);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00E8(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00E8),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00E8 )
    );
assign o_prog_coff58        = rw_reg_h00E8[15:0];

//------------------------------------------------------------
// 0X00EC
//------------------------------------------------------------
assign wen_h00EC = wr_en & reg_cs & (addr == 16'h00EC);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00EC(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00EC),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00EC )
    );
assign o_prog_coff59        = rw_reg_h00EC[15:0];

//------------------------------------------------------------
// 0X00F0
//------------------------------------------------------------
assign wen_h00F0 = wr_en & reg_cs & (addr == 16'h00F0);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00F0(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00F0),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00F0 )
    );
assign o_prog_coff60        = rw_reg_h00F0[15:0];

//------------------------------------------------------------
// 0X00F4
//------------------------------------------------------------
assign wen_h00F4 = wr_en & reg_cs & (addr == 16'h00F4);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00F4(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00F4),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00F4 )
    );
assign o_prog_coff61        = rw_reg_h00F4[15:0];

//------------------------------------------------------------
// 0X00F8
//------------------------------------------------------------
assign wen_h00F8 = wr_en & reg_cs & (addr == 16'h00F8);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00F8(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00F8),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00F8 )
    );
assign o_prog_coff62        = rw_reg_h00F8[15:0];

//------------------------------------------------------------
// 0X00FC
//------------------------------------------------------------
assign wen_h00FC = wr_en & reg_cs & (addr == 16'h00FC);

RW_REG #(.DW(16), .INIT(16'h0)) U_RW_REG_H00FC(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h00FC),
    .datain (wdata[15:0]),
    .dataout(rw_reg_h00FC )
    );
assign o_prog_coff63        = rw_reg_h00FC[15:0];

//------------------------------------------------------------
// 0X0100
//------------------------------------------------------------
assign wen_h0100 = wr_en & reg_cs & (addr == 16'h0100);

RW_REG #(.DW(13), .INIT({11'h0,1'h0,1'h0})) U_RW_REG_H0100(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0100),
    .datain ({wdata[12:2],wdata[1],wdata[0]}),
    .dataout(rw_reg_h0100 )
    );
assign o_clk_gate           = rw_reg_h0100[12:2];
assign o_iq_switch          = rw_reg_h0100[1];
assign o_sw_reset           = rw_reg_h0100[0];

//------------------------------------------------------------
// 0X0104
//------------------------------------------------------------
assign wen_h0104 = wr_en & reg_cs & (addr == 16'h0104);

RW_REG #(.DW(31), .INIT({1'h0,1'h0,3'h0,1'h0,1'h0,1'h0,1'h0,4'h0,1'h0,1'h0,2'h0,1'h0,5'h0,4'h0,1'h0,3'h0})) U_RW_REG_H0104(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0104),
    .datain ({wdata[30],wdata[29],wdata[28:26],wdata[25],wdata[24],wdata[23],wdata[22],wdata[21:18],wdata[17],wdata[16],wdata[15:14],wdata[13],wdata[12:8],wdata[7:4],wdata[3],wdata[2:0]}),
    .dataout(rw_reg_h0104 )
    );
assign o_dgc_bypass         = rw_reg_h0104[30];
assign o_notch_en           = rw_reg_h0104[29];
assign o_notch_bypass       = rw_reg_h0104[28:26];
assign o_mix_bypass         = rw_reg_h0104[25];
assign o_mix_enable         = rw_reg_h0104[24];
assign o_hbf3_bypass        = rw_reg_h0104[23];
assign o_hbf2_bypass        = rw_reg_h0104[22];
assign o_hbf_band_sel       = rw_reg_h0104[21:18];
assign o_bypass_dc_est      = rw_reg_h0104[17];
assign o_bypass_hbf         = rw_reg_h0104[16];
assign o_cic_mode           = rw_reg_h0104[15:14];
assign o_hbf1_bypass        = rw_reg_h0104[13];
assign o_prog_clk_gen       = rw_reg_h0104[12:8];
assign o_prog_clk_mod       = rw_reg_h0104[7:4];
assign o_prog_bypass        = rw_reg_h0104[3];
assign o_prog_dec_mode_l    = rw_reg_h0104[2:0];

//------------------------------------------------------------
// 0X0108
//------------------------------------------------------------
assign wen_h0108 = wr_en & reg_cs & (addr == 16'h0108);

RW_REG #(.DW(3), .INIT(3'h0)) U_RW_REG_H0108(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0108),
    .datain (wdata[2:0]),
    .dataout(rw_reg_h0108 )
    );
assign o_prog_dec_mode_h    = rw_reg_h0108[2:0];

//------------------------------------------------------------
// 0X010C
//------------------------------------------------------------
assign wen_h010C = wr_en & reg_cs & (addr == 16'h010C);

RW_REG #(.DW(32), .INIT(32'h0)) U_RW_REG_H010C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h010C),
    .datain (wdata[31:0]),
    .dataout(rw_reg_h010C )
    );
assign o_nco_phase_init_l   = rw_reg_h010C[31:0];

//------------------------------------------------------------
// 0X0110
//------------------------------------------------------------
assign wen_h0110 = wr_en & reg_cs & (addr == 16'h0110);

RW_REG #(.DW(7), .INIT(7'h0)) U_RW_REG_H0110(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0110),
    .datain (wdata[6:0]),
    .dataout(rw_reg_h0110 )
    );
assign o_nco_phase_init_h   = rw_reg_h0110[6:0];

//------------------------------------------------------------
// 0X0114
//------------------------------------------------------------
assign wen_h0114 = wr_en & reg_cs & (addr == 16'h0114);

RW_REG #(.DW(32), .INIT(32'h0)) U_RW_REG_H0114(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0114),
    .datain (wdata[31:0]),
    .dataout(rw_reg_h0114 )
    );
assign o_nco_phase_inc_l    = rw_reg_h0114[31:0];

//------------------------------------------------------------
// 0X0118
//------------------------------------------------------------
assign wen_h0118 = wr_en & reg_cs & (addr == 16'h0118);

RW_REG #(.DW(7), .INIT(7'h0)) U_RW_REG_H0118(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0118),
    .datain (wdata[14:8]),
    .dataout(rw_reg_h0118 )
    );
assign o_nco_phase_inc_h    = rw_reg_h0118[6:0];

//------------------------------------------------------------
// 0X011C
//------------------------------------------------------------
assign wen_h011C = wr_en & reg_cs & (addr == 16'h011C);

RW_REG #(.DW(8), .INIT(8'h0)) U_RW_REG_H011C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h011C),
    .datain (wdata[7:0]),
    .dataout(rw_reg_h011C )
    );
assign o_dgc_gain           = rw_reg_h011C[7:0];

//------------------------------------------------------------
// 0X0120
//------------------------------------------------------------
assign wen_h0120 = wr_en & reg_cs & (addr == 16'h0120);

RW_REG #(.DW(32), .INIT(32'h0)) U_RW_REG_H0120(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0120),
    .datain (wdata[31:0]),
    .dataout(rw_reg_h0120 )
    );
assign o_notch_fcos_l       = rw_reg_h0120[31:0];

//------------------------------------------------------------
// 0X0124
//------------------------------------------------------------
assign wen_h0124 = wr_en & reg_cs & (addr == 16'h0124);

RW_REG #(.DW(28), .INIT(28'h0)) U_RW_REG_H0124(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0124),
    .datain (wdata[27:0]),
    .dataout(rw_reg_h0124 )
    );
assign o_notch_fcos_h       = rw_reg_h0124[27:0];

//------------------------------------------------------------
// 0X0128
//------------------------------------------------------------
assign wen_h0128 = wr_en & reg_cs & (addr == 16'h0128);

RW_REG #(.DW(32), .INIT(32'h0)) U_RW_REG_H0128(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0128),
    .datain (wdata[31:0]),
    .dataout(rw_reg_h0128 )
    );
assign o_notch_fsin_l       = rw_reg_h0128[31:0];

//------------------------------------------------------------
// 0X012C
//------------------------------------------------------------
assign wen_h012C = wr_en & reg_cs & (addr == 16'h012C);

RW_REG #(.DW(28), .INIT(28'h0)) U_RW_REG_H012C(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h012C),
    .datain (wdata[27:0]),
    .dataout(rw_reg_h012C )
    );
assign o_notch_fsin_h       = rw_reg_h012C[27:0];

//------------------------------------------------------------
// 0X0130
//------------------------------------------------------------
assign wen_h0130 = wr_en & reg_cs & (addr == 16'h0130);

RW_REG #(.DW(28), .INIT({4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0})) U_RW_REG_H0130(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0130),
    .datain ({wdata[27:24],wdata[23:20],wdata[19:16],wdata[15:12],wdata[11:8],wdata[7:4],wdata[3:0]}),
    .dataout(rw_reg_h0130 )
    );
assign o_notch_type0_t2     = rw_reg_h0130[27:24];
assign o_notch_type0_t1     = rw_reg_h0130[23:20];
assign o_notch_type0_t0     = rw_reg_h0130[19:16];
assign o_notch_type0_k3     = rw_reg_h0130[15:12];
assign o_notch_type0_k2     = rw_reg_h0130[11:8];
assign o_notch_type0_k1     = rw_reg_h0130[7:4];
assign o_notch_type0_k0     = rw_reg_h0130[3:0];

//------------------------------------------------------------
// 0X0134
//------------------------------------------------------------
assign wen_h0134 = wr_en & reg_cs & (addr == 16'h0134);

RW_REG #(.DW(28), .INIT({4'h0,4'h0,4'h0,4'h0,4'h0,4'h0,4'h0})) U_RW_REG_H0134(
    .clk    (clk    ),
    .rst_n  (rst_n  ),
    .wen    (wen_h0134),
    .datain ({wdata[27:24],wdata[23:20],wdata[19:16],wdata[15:12],wdata[11:8],wdata[7:4],wdata[3:0]}),
    .dataout(rw_reg_h0134 )
    );
assign o_notch_type1_t2     = rw_reg_h0134[27:24];
assign o_notch_type1_t1     = rw_reg_h0134[23:20];
assign o_notch_type1_t0     = rw_reg_h0134[19:16];
assign o_notch_type1_k3     = rw_reg_h0134[15:12];
assign o_notch_type1_k2     = rw_reg_h0134[11:8];
assign o_notch_type1_k1     = rw_reg_h0134[7:4];
assign o_notch_type1_k0     = rw_reg_h0134[3:0];

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        dataout <= 32'h0;
    end
    else begin
        if (rd_en & reg_cs) begin
            case(addr) 
                16'h0000: dataout <= {16'h0,o_prog_coff0};
                16'h0004: dataout <= {16'h0,o_prog_coff1};
                16'h0008: dataout <= {16'h0,o_prog_coff2};
                16'h000C: dataout <= {16'h0,o_prog_coff3};
                16'h0010: dataout <= {16'h0,o_prog_coff4};
                16'h0014: dataout <= {16'h0,o_prog_coff5};
                16'h0018: dataout <= {16'h0,o_prog_coff6};
                16'h001C: dataout <= {16'h0,o_prog_coff7};
                16'h0020: dataout <= {16'h0,o_prog_coff8};
                16'h0024: dataout <= {16'h0,o_prog_coff9};
                16'h0028: dataout <= {16'h0,o_prog_coff10};
                16'h002C: dataout <= {16'h0,o_prog_coff11};
                16'h0030: dataout <= {16'h0,o_prog_coff12};
                16'h0034: dataout <= {16'h0,o_prog_coff13};
                16'h0038: dataout <= {16'h0,o_prog_coff14};
                16'h003C: dataout <= {16'h0,o_prog_coff15};
                16'h0040: dataout <= {16'h0,o_prog_coff16};
                16'h0044: dataout <= {16'h0,o_prog_coff17};
                16'h0048: dataout <= {16'h0,o_prog_coff18};
                16'h004C: dataout <= {16'h0,o_prog_coff19};
                16'h0050: dataout <= {16'h0,o_prog_coff20};
                16'h0054: dataout <= {16'h0,o_prog_coff21};
                16'h0058: dataout <= {16'h0,o_prog_coff22};
                16'h005C: dataout <= {16'h0,o_prog_coff23};
                16'h0060: dataout <= {16'h0,o_prog_coff24};
                16'h0064: dataout <= {16'h0,o_prog_coff25};
                16'h0068: dataout <= {16'h0,o_prog_coff26};
                16'h006C: dataout <= {16'h0,o_prog_coff27};
                16'h0070: dataout <= {16'h0,o_prog_coff28};
                16'h0074: dataout <= {16'h0,o_prog_coff29};
                16'h0078: dataout <= {16'h0,o_prog_coff30};
                16'h007C: dataout <= {16'h0,o_prog_coff31};
                16'h0080: dataout <= {16'h0,o_prog_coff32};
                16'h0084: dataout <= {16'h0,o_prog_coff33};
                16'h0088: dataout <= {16'h0,o_prog_coff34};
                16'h008C: dataout <= {16'h0,o_prog_coff35};
                16'h0090: dataout <= {16'h0,o_prog_coff36};
                16'h0094: dataout <= {16'h0,o_prog_coff37};
                16'h0098: dataout <= {16'h0,o_prog_coff38};
                16'h009C: dataout <= {16'h0,o_prog_coff39};
                16'h00A0: dataout <= {16'h0,o_prog_coff40};
                16'h00A4: dataout <= {16'h0,o_prog_coff41};
                16'h00A8: dataout <= {16'h0,o_prog_coff42};
                16'h00AC: dataout <= {16'h0,o_prog_coff43};
                16'h00B0: dataout <= {16'h0,o_prog_coff44};
                16'h00B4: dataout <= {16'h0,o_prog_coff45};
                16'h00B8: dataout <= {16'h0,o_prog_coff46};
                16'h00BC: dataout <= {16'h0,o_prog_coff47};
                16'h00C0: dataout <= {16'h0,o_prog_coff48};
                16'h00C4: dataout <= {16'h0,o_prog_coff49};
                16'h00C8: dataout <= {16'h0,o_prog_coff50};
                16'h00CC: dataout <= {16'h0,o_prog_coff51};
                16'h00D0: dataout <= {16'h0,o_prog_coff52};
                16'h00D4: dataout <= {16'h0,o_prog_coff53};
                16'h00D8: dataout <= {16'h0,o_prog_coff54};
                16'h00DC: dataout <= {16'h0,o_prog_coff55};
                16'h00E0: dataout <= {16'h0,o_prog_coff56};
                16'h00E4: dataout <= {16'h0,o_prog_coff57};
                16'h00E8: dataout <= {16'h0,o_prog_coff58};
                16'h00EC: dataout <= {16'h0,o_prog_coff59};
                16'h00F0: dataout <= {16'h0,o_prog_coff60};
                16'h00F4: dataout <= {16'h0,o_prog_coff61};
                16'h00F8: dataout <= {16'h0,o_prog_coff62};
                16'h00FC: dataout <= {16'h0,o_prog_coff63};
                16'h0100: dataout <= {19'h0,o_clk_gate,o_iq_switch,o_sw_reset};
                16'h0104: dataout <= {1'h0,o_dgc_bypass,o_notch_en,o_notch_bypass,o_mix_bypass,o_mix_enable,o_hbf3_bypass,o_hbf2_bypass,o_hbf_band_sel,o_bypass_dc_est,o_bypass_hbf,o_cic_mode,o_hbf1_bypass,o_prog_clk_gen,o_prog_clk_mod,o_prog_bypass,o_prog_dec_mode_l};
                16'h0108: dataout <= {29'h0,o_prog_dec_mode_h};
                16'h010C: dataout <= o_nco_phase_init_l;
                16'h0110: dataout <= {25'h0,o_nco_phase_init_h};
                16'h0114: dataout <= o_nco_phase_inc_l;
                16'h0118: dataout <= {17'h0,o_nco_phase_inc_h,8'h0};
                16'h011C: dataout <= {24'h0,o_dgc_gain};
                16'h0120: dataout <= o_notch_fcos_l;
                16'h0124: dataout <= {4'h0,o_notch_fcos_h};
                16'h0128: dataout <= o_notch_fsin_l;
                16'h012C: dataout <= {4'h0,o_notch_fsin_h};
                16'h0130: dataout <= {4'h0,o_notch_type0_t2,o_notch_type0_t1,o_notch_type0_t0,o_notch_type0_k3,o_notch_type0_k2,o_notch_type0_k1,o_notch_type0_k0};
                16'h0134: dataout <= {4'h0,o_notch_type1_t2,o_notch_type1_t1,o_notch_type1_t0,o_notch_type1_k3,o_notch_type1_k2,o_notch_type1_k1,o_notch_type1_k0};
                default : dataout <= 32'h0;
            endcase
        end
    end
end

endmodule

