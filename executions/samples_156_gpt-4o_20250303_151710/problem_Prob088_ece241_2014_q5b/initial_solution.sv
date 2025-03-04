module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    // State encoding
    logic [1:0] state;
    parameter A = 2'b01;
    parameter B = 2'b10;

    // Sequential logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            z <= 0;
        end else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B;
                        z <= 1;
                    end else begin
                        z <= 0;
                    end
                end
                B: begin
                    if (x) begin
                        z <= 0;
                    end else begin
                        z <= 1;
                    end
                end
            endcase
        end
    end
endmodule