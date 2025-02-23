module TopModule
(
  input  logic       clk,
  input  logic       areset,
  input  logic       predict_valid,
  input  logic       predict_taken,
  input  logic       train_mispredicted,
  input  logic       train_taken,
  input  logic [31:0] train_history,
  output logic [31:0] predict_history
);

  // Sequential logic

  logic [31:0] reg_history;

  always @( posedge clk or posedge areset ) begin
    if ( areset )
      reg_history <= 32'b0;
    else if ( train_mispredicted )
      reg_history <= {train_history[30:0], train_taken};
    else if ( predict_valid )
      reg_history <= {reg_history[30:0], predict_taken};
  end

  // Structural connections

  assign predict_history = reg_history;

endmodule