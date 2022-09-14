module vga_controller(VGAclk, reset, hsync, vsync, o_x, o_y);
    input VGAclk, reset;
    output hsync, vsync;
    output wire [9:0] o_x, o_y;
    
    reg [9:0] hcount, vcount;
    
    localparam HMAX = 799;
    localparam HACTIVE_START = 0;
    localparam HACTIVE_END = 639;
    localparam HSYNC_START = HACTIVE_END + 16;
    localparam HSYNC_END = HSYNC_START + 96;
        
    localparam VMAX = 524;
    localparam VACTIVE_START = 0;
    localparam VACTIVE_END = 479;
    localparam VSYNC_START = VACTIVE_END + 10;
    localparam VSYNC_END = VSYNC_START + 2;
    
    assign o_x = hcount <= HMAX ? hcount : HMAX;
    assign o_y = vcount <= VMAX ? vcount : VMAX;
    
    assign hsync = o_x < HSYNC_START || o_x > HSYNC_END;
    assign vsync = o_y < VSYNC_START || o_y > VSYNC_END;

    always @ (posedge VGAclk) begin
        if(reset) begin
            vcount <= 0;
            hcount <= 0;
        end
        if (hcount == HMAX && vcount != VMAX) begin
            vcount <= vcount + 1;
            hcount <= 0;
        end
        
        else if (hcount == HMAX && vcount == VMAX) begin
            vcount <= 0;
            hcount <= 0;
        end
        else begin
            hcount <= hcount + 1;
        end
    end

endmodule
