module TopModule (
    input logic clk,
    input logic reset_n,
    input logic d,
    output logic q
);

    logic rising_d, falling_d;
    logic clk_div;

    // Clock divider to emulate dual-edge behavior
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            clk_div <= 1'b0;
        else
            clk_div <= ~clk_div;
    end

    // Capture data on rising edge
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            rising_d <= 1'b0;
        else
            rising_d <= d;
    end

    // Capture data on falling edge
    always_ff @(negedge clk or negedge reset_n) begin
        if (!reset_n)
            falling_d <= 1'b0;
        else
            falling_d <= d;
    end

    // Multiplexer to select between rising and falling edge data
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 1'b0;
        else
            q <= clk_div ? rising_d : falling_d;
    end

endmodule