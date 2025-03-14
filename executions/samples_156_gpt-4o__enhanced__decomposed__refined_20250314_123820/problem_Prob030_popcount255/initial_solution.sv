[BEGIN]
module TopModule(
    input  [254:0] in,
    output logic [7:0] out
);
    // Intermediate population count variable
    logic [7:0] pop_count;
    
    integer i;
    
    always @(*) begin
        pop_count = 8'b0;
        for (i = 0; i < 255; i = i + 1) begin
            pop_count = pop_count + in[i];
        end
    end

    assign out = pop_count;

endmodule
[DONE]