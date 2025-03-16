module TopModule(
    input logic in,
    input logic [1:0] state,
    output logic [1:0] next_state,
    output logic out
);

    // State encoding
    localparam logic [1:0] A = 2'b00;
    localparam logic [1:0] B = 2'b01;
    localparam logic [1:0] C = 2'b10;
    localparam logic [1:0] D = 2'b11;

    // Combinational logic for state transition and output
    always @(*) begin
        case (state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
                out = 1'b0;
            end
            B: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b0;
            end
            C: begin
                next_state = (in == 1'b0) ? A : D;
                out = 1'b0;
            end
            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b1;
            end
            default: begin
                next_state = A;
                out = 1'b0;
            end
        endcase
    end

endmodule