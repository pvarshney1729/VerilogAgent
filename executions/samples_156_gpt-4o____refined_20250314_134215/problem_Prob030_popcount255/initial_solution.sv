[BEGIN]
module TopModule (
    input  logic [254:0] in,
    output logic [7:0]   out
);

    logic [7:0] pop_count;

    always @(*) begin
        pop_count = 8'd0;
        for (int i = 0; i < 255; i++) begin
            pop_count = pop_count + in[i];
        end
    end

    assign out = pop_count;

endmodule
[DONE]