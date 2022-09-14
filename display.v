module display (switchClk, rst, score, segval, whichseg);
   
    input switchClk;
    input rst;
    input [13:0] score;
    output reg [6:0] segval;
    output reg [3:0] whichseg;

    reg [1:0] cntr;
    wire [6:0] digitval [3:0];
   
    assign digitval[0] = score % 10;
    assign digitval[1] = (score / 10) % 10;
    assign digitval[2] = (score / 100) % 10;
    assign digitval[3] = (score / 1000) % 10;
    
    // Which segment currently on
    always @ (*) begin
        case(cntr)
            0: begin whichseg = 4'b0111; end
            1: begin whichseg = 4'b1011; end
            2: begin whichseg = 4'b1101; end
            3: begin whichseg = 4'b1110; end
            default:  begin whichseg = 4'b0111; end
        endcase
    end
    
    // Value of segment currently on
    always @ (*) begin
        case(digitval[cntr])
            0: segval = 7'b0000001; // "0"     
            1: segval = 7'b1001111; // "1" 
            2: segval = 7'b0010010; // "2" 
            3: segval = 7'b0000110; // "3" 
            4: segval = 7'b1001100; // "4" 
            5: segval = 7'b0100100; // "5" 
            6: segval = 7'b0100000; // "6" 
            7: segval = 7'b0001111; // "7" 
            8: segval = 7'b0000000; // "8"     
            9: segval = 7'b0000100; // "9" 
            default: segval = 7'b0000001; // "0"
        endcase
    end
    
    // Switch between all segments
    always @(posedge switchClk) begin
        if (rst) begin
            cntr <= 0;
        end
        else begin
            cntr <= cntr + 1;
        end
    end
    
endmodule
