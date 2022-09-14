// Top level module
module guitar_hero(clk, btnRst, sw, hsync, vsync, buzzer, r, g, b, o_segval, o_whichseg);
    
    input clk, btnRst;
    input [4:0] sw;
    
    output hsync, vsync;
    output reg [2:0] r, g;
    output reg [1:0] b;
    output [3:0] o_whichseg;
    output [6:0] o_segval;
    output reg buzzer;
    
    wire reset, VGAclk, gameclk, switchClk;
    wire a3, b3, c4, d4, e4;
    wire [9:0] x, y;
    wire [9:0] note1_xl, note1_xh, note1_yl, note1_yh;
    wire [9:0] note2_xl, note2_xh, note2_yl, note2_yh;
    wire [9:0] note3_xl, note3_xh, note3_yl, note3_yh;
    wire [9:0] note4_xl, note4_xh, note4_yl, note4_yh;
    wire [9:0] note5_xl, note5_xh, note5_yl, note5_yh;
    wire [13:0] total_score;
    reg [13:0] note1_score, note2_score, note3_score, note4_score, note5_score;
    reg [3:0] rstHist;
    
    // Assigns
    assign reset = ~rstHist[3] & ~rstHist[2] & rstHist[1] & rstHist[0];
    assign total_score = note1_score + note2_score + note3_score + note4_score + note5_score;
    
    // Button state machine
    always @(posedge gameclk) begin
        rstHist <= {rstHist[2], rstHist[1], rstHist[0], btnRst};
    end
    
 
    // Game functionality Clock Dividers
    clock_divider #(4) clock_vga(.in_clk(clk), .rst(reset), .out_clk(VGAclk));
    clock_divider #(500000) clock_game (.in_clk(clk), .rst(reset), .out_clk(gameclk));
    clock_divider #(5000) clock_disp (.in_clk(clk), .rst(reset), .out_clk(switchClk)); 
    
    // I/O Modules
    vga_controller vga (.VGAclk(VGAclk), .reset(reset), .hsync(hsync), .vsync(vsync), .o_x(x), .o_y(y));
    display disp(.switchClk(switchClk), .rst(reset), .score(total_score), .segval(o_segval), .whichseg(o_whichseg));
    
    // Note Modules
    note #(114, 40, 73, 133) note1 (.gameclk(gameclk), .in_reset(reset), .o_xlow(note1_xl), .o_xhigh(note1_xh), .o_ylow(note1_yl), .o_yhigh(note1_yh));
    note #(216, 40, 123, 67) note2 (.gameclk(gameclk), .in_reset(reset), .o_xlow(note2_xl), .o_xhigh(note2_xh), .o_ylow(note2_yl), .o_yhigh(note2_yh));
    note #(318, 40, 53, 180) note3 (.gameclk(gameclk), .in_reset(reset), .o_xlow(note3_xl), .o_xhigh(note3_xh), .o_ylow(note3_yl), .o_yhigh(note3_yh));
    note #(420, 40, 152, 43) note4 (.gameclk(gameclk), .in_reset(reset), .o_xlow(note4_xl), .o_xhigh(note4_xh), .o_ylow(note4_yl), .o_yhigh(note4_yh));
    note #(522, 40, 85, 115) note5 (.gameclk(gameclk), .in_reset(reset), .o_xlow(note5_xl), .o_xhigh(note5_xh), .o_ylow(note5_yl), .o_yhigh(note5_yh));
    
    // Buzzer Modules
    clock_divider #(100000000 / 220) play_a3 (.in_clk(clk), .rst(reset), .out_clk(a3));
    clock_divider #(100000000 / 247) play_b3 (.in_clk(clk), .rst(reset), .out_clk(b3));
    clock_divider #(100000000 / 262) play_c4 (.in_clk(clk), .rst(reset), .out_clk(c4));
    clock_divider #(100000000 / 294) play_d4 (.in_clk(clk), .rst(reset), .out_clk(d4));
    clock_divider #(100000000 / 330) play_e4 (.in_clk(clk), .rst(reset), .out_clk(e4));
    
    
    // Parameters
    localparam THICKNESS = 1;
    localparam VERTICAL_END = 431;
    localparam LINEV_1 = 63;
    localparam LINEV_2 = 165;
    localparam LINEV_3 = 267;
    localparam LINEV_4 = 369;
    localparam LINEV_5 = 471;
    localparam LINEV_6 = 573;
    localparam BOTTOM_LINE = 361;
    
    // Drawing Logic
    always @ (*) begin 
        // FIRST VERTICAL LINE 
        if(x >= LINEV_1 - THICKNESS && x <= LINEV_1 + THICKNESS && y <= VERTICAL_END) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(x >= LINEV_2 - THICKNESS && x <= LINEV_2 + THICKNESS && y <= VERTICAL_END) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(x >= LINEV_3 - THICKNESS && x <= LINEV_3 + THICKNESS && y <= VERTICAL_END) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(x >= LINEV_4 - THICKNESS && x <= LINEV_4 + THICKNESS && y <= VERTICAL_END) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(x >= LINEV_5 - THICKNESS && x <= LINEV_5 + THICKNESS && y <= VERTICAL_END) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(x >= LINEV_6 - THICKNESS && x <= LINEV_6 + THICKNESS && y <= VERTICAL_END) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(x >= LINEV_1 && x <= LINEV_6 && y >= VERTICAL_END - THICKNESS && y <= VERTICAL_END + THICKNESS) begin
            r = 3'b011;
            g = 3'b011;
            b = 2'b01;
        end
        else if(y >= BOTTOM_LINE - THICKNESS && y <= BOTTOM_LINE + THICKNESS) begin
            r = 3'b111;
            g = 3'b111;
            b = 2'b11;
        end
        else if (y > VERTICAL_END + THICKNESS) begin
            r = 3'b000;
            g = 3'b000;
            b = 2'b00;
        end
        else if(x >= note1_xl && x <= note1_xh && y >= note1_yl && y <= note1_yh) begin
            r = 3'b111;
            g = 3'b000;
            b = 2'b00;
        end
        else if(x >= note2_xl && x <= note2_xh && y >= note2_yl && y <= note2_yh) begin
            r = 3'b000;
            g = 3'b000;
            b = 2'b11;
        end
        else if(x >= note3_xl && x <= note3_xh && y >= note3_yl && y <= note3_yh) begin
            r = 3'b000;
            g = 3'b111;
            b = 2'b00;
        end
        else if(x >= note4_xl && x <= note4_xh && y >= note4_yl && y <= note4_yh) begin
            r = 3'b111;
            g = 3'b111;
            b = 2'b00;
        end
        else if(x >= note5_xl && x <= note5_xh && y >= note5_yl && y <= note5_yh) begin
            r = 3'b111;
            g = 3'b000;
            b = 2'b11;
        end
        else begin
            r = 3'b000;
            g = 3'b000;
            b = 2'b00;
        end    
    end
    
   //Scoring Logic
   always @ (posedge gameclk) begin
    if(reset) begin
        note1_score <= 0;
        note2_score <= 0;
        note3_score <= 0;
        note4_score <= 0;
        note5_score <= 0;
    end
    else begin
        //NOTE ONE
        if (sw[4] && note1_yl <= BOTTOM_LINE - THICKNESS && note1_yh >= BOTTOM_LINE + THICKNESS) begin
            note1_score <= note1_score + 1;
        end
        else if (sw[4] && !(note1_yl <= BOTTOM_LINE - THICKNESS && note1_yh >= BOTTOM_LINE + THICKNESS) && note1_score > 0) begin
            note1_score <= note1_score - 1;
        end
        
        
        //NOTE TWO
        if (sw[3] && note2_yl <= BOTTOM_LINE - THICKNESS && note2_yh >= BOTTOM_LINE + THICKNESS) begin
            note2_score <= note2_score + 1;
        end
        else if (sw[3] && !(note2_yl <= BOTTOM_LINE - THICKNESS && note2_yh >= BOTTOM_LINE + THICKNESS) && note2_score > 0) begin
            note2_score <= note2_score - 1;
        end
        
        
        //NOTE THREE
        if (sw[2] && note3_yl <= BOTTOM_LINE - THICKNESS && note3_yh >= BOTTOM_LINE + THICKNESS) begin
            note3_score <= note3_score + 1;
        end
        else if (sw[2] && !(note3_yl <= BOTTOM_LINE - THICKNESS && note3_yh >= BOTTOM_LINE + THICKNESS) && note3_score > 0) begin
            note3_score <= note3_score - 1;
        end
        
        //NOTE FOUR
        if (sw[1] && note4_yl <= BOTTOM_LINE - THICKNESS && note4_yh >= BOTTOM_LINE + THICKNESS) begin
            note4_score <= note4_score + 1;
        end
        else if (sw[1] && !(note4_yl <= BOTTOM_LINE - THICKNESS && note4_yh >= BOTTOM_LINE + THICKNESS) && note4_score > 0) begin
            note4_score <= note4_score - 1;
        end
        
        //NOTE FIVE
        if (sw[0] && note5_yl <= BOTTOM_LINE - THICKNESS && note5_yh >= BOTTOM_LINE + THICKNESS) begin
            note5_score <= note5_score + 1;
        end
        else if (sw[0] && !(note5_yl <= BOTTOM_LINE - THICKNESS && note5_yh >= BOTTOM_LINE + THICKNESS) && note5_score > 0) begin
            note5_score <= note5_score - 1;
        end
    end
   end
   
   // Buzzer Logic
   always @ (*) begin
        casex(sw) 
            5'b00000: buzzer = 1'b01;
            5'b1xxxx: buzzer = a3;
            5'b01xxx: buzzer = b3;
            5'b001xx: buzzer = c4;
            5'b0001x: buzzer = d4;
            5'b00001: buzzer = e4;
            default : buzzer = 1'b0;
        endcase
   end
    
endmodule
