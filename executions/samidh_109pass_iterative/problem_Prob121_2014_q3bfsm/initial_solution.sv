module TopModule (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic [2:0] y;

    always_ff @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
            z <= 1'b0;
        end else begin
            case (y)
                3'b000: begin
                    if (x) y <= 3'b001;
                    z <= 1'b0;
                end
                3'b001: begin
                    if (x) y <= 3'b100;
                    z <= 1'b0;
                end
                3'b010: begin
                    if (x) y <= 3'b001;
                    z <= 1'b0;
                end
                3'b011: begin
                    if (x) y <= 3'b010;
                    else y <= 3'b001;
                    z <= 1'b1;
                end
                3'b100: begin
                    if (!x) y <= 3'b011;
                    z <= 1'b1;
                end
                default: begin
                    y <= 3'b000;
                    z <= 1'b0;
                end
            endcase
        end
    end

endmodule