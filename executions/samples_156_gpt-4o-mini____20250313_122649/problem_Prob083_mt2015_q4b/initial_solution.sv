module TopModule (
    input logic x,
    input logic y,
    output logic z
);

    logic state;

    always @(*) begin
        case (state)
            1'b0: begin
                if (x && !y) 
                    z = 1'b0;
                else if (!x && y) 
                    z = 1'b0;
                else 
                    z = 1'b1;
            end
            1'b1: begin
                if (x && y) 
                    z = 1'b1;
                else 
                    z = 1'b0;
            end
        endcase
    end

    always @(posedge x or posedge y) begin
        if (x && !y) 
            state <= 1'b0;
        else if (!x && y) 
            state <= 1'b1;
        else if (x && y) 
            state <= 1'b1;
        else 
            state <= 1'b0;
    end

endmodule