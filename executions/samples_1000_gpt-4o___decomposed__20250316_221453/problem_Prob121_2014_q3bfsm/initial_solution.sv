module TopModule(
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    logic [2:0] y, y_next;

    // State transition logic
    always @(*) begin
        case (y)
            3'b000: y_next = (x == 1'b0) ? 3'b000 : 3'b001;
            3'b001: y_next = (x == 1'b0) ? 3'b001 : 3'b100;
            3'b010: y_next = (x == 1'b0) ? 3'b010 : 3'b001;
            3'b011: y_next = (x == 1'b0) ? 3'b001 : 3'b010;
            3'b100: y_next = (x == 1'b0) ? 3'b011 : 3'b100;
            default: y_next = 3'b000;
        endcase
    end

    // Output logic
    always @(*) begin
        case (y)
            3'b011, 3'b100: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            y <= 3'b000;
        end else begin
            y <= y_next;
        end
    end

endmodule