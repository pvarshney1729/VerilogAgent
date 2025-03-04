module TopModule (
    input logic clk,
    input logic rst_n,
    input logic d,
    output logic q
);

    // Alternative processes to emulate dual-edge behavior
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end

    always_ff @(negedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule