module TopModule (
    input logic clk,
    input logic reset_n,
    input logic load,
    input logic [9:0] load_value,
    output logic [9:0] count,
    output logic tc
);

    always_ff @(posedge clk) begin
        if (!reset_n) begin
            count <= 10'b0;
        end else if (load) begin
            count <= load_value;
        end else begin
            count <= count + 1;
        end
    end

    always_comb begin
        if (load) begin
            tc = 1'b0;
        end else begin
            tc = (count == 10'b1111111111);
        end
    end

endmodule