module clock_divider #(parameter DIV = 2)(in_clk, rst, out_clk);
	input in_clk;
    input rst;
	output reg out_clk;
	reg [31:0] counter;
	always @ (posedge in_clk) begin
        // Reset
        if(rst) begin
            out_clk <= 0;
            counter <= 0; 
        end
        // Counted DIV/2 posedges (DIV edges), so flip out_clk
		if (counter == (DIV/2) - 1) begin
			out_clk <= ~out_clk;
			counter <= 0;
		end
        // Else inc
		else begin
			counter <= counter + 1;
        end
	end
endmodule