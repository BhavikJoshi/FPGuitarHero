module note #(parameter H_MIDDLE = 320, WIDTH = 40, HEIGHT0 = 100, HEIGHT1 = 100)(gameclk, in_reset, o_xlow, o_xhigh, o_ylow, o_yhigh);
    
   input gameclk, in_reset;
   output [9:0] o_xlow, o_xhigh, o_ylow;
   output reg [9:0] o_yhigh;
   
   wire [8:0] height;
   reg heightState;
   
   localparam SCREEN = 479;
   
   assign o_xlow = H_MIDDLE - WIDTH;
   assign o_xhigh = H_MIDDLE + WIDTH;
   assign o_ylow = o_yhigh - height;
   
   assign height = heightState ? HEIGHT0 : HEIGHT1;
   
   always @(posedge gameclk) begin
        if(in_reset) begin
            o_yhigh <= 0;
            heightState <= 0;
        end
        else if(o_yhigh > SCREEN + height) begin
            o_yhigh <= 0;
            heightState <= ~heightState;
        end
        else begin
          o_yhigh <= o_yhigh + 1;
        end
    end

endmodule
