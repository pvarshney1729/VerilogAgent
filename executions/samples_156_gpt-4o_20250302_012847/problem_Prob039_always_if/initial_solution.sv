module TopModule (
    input logic sel,
    input logic [1:0] in0,
    input logic [1:0] in1,
    output logic [1:0] out
);

    // Combinational logic using assign statement
    assign out = sel ? in1 : in0;

    // Combinational logic using always block
    always @(*) begin
        if (sel) begin
            out = in1;
        end else begin
            out = in0;
        end
    end

endmodule