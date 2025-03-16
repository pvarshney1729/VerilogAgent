module TopModule (
    input logic x,
    input logic y,
    output logic z
);

logic state;

always @(*) begin
    case (state)
        1'b0: z = (x & y) ? 1'b1 : 1'b0; // State 0
        1'b1: z = (x & y) ? 1'b1 : 1'b0; // State 1
        default: z = 1'b0;
    endcase
end

always @(posedge x or posedge y) begin
    if (x) begin
        state <= 1'b1;
    end else if (y) begin
        state <= 1'b0;
    end
end

initial begin
    state = 1'b0;
    z = 1'b1; // Initial condition
end

endmodule