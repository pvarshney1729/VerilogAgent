module TopModule (
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    // State encoding using localparam
    localparam logic [3:0] A = 4'b0001;
    localparam logic [3:0] B = 4'b0010;
    localparam logic [3:0] C = 4'b0100;
    localparam logic [3:0] D = 4'b1000;

    always @(*) begin
        // Default assignments
        next_state = 4'b0000;
        out = 1'b0;

        case (state)
            A: begin
                next_state = in ? B : A;
                out = 1'b0;
            end
            B: begin
                next_state = in ? B : C;
                out = 1'b0;
            end
            C: begin
                next_state = in ? D : A;
                out = 1'b0;
            end
            D: begin
                next_state = in ? B : C;
                out = 1'b1;
            end
            default: begin
                next_state = A; // Default to state A
                out = 1'b0;
            end
        endcase
    end

endmodule