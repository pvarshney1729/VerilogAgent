module TopModule
(
  input  logic       clk,
  input  logic       areset,

  input  logic       predict_valid,
  input  logic [6:0] predict_pc,
  output logic       predict_taken,
  output logic [6:0] predict_history,

  input  logic       train_valid,
  input  logic       train_taken,
  input  logic       train_mispredicted,
  input  logic [6:0] train_history,
  input  logic [6:0] train_pc
);

  // 128-entry table of two-bit saturating counters
  logic [1:0] pht [0:127];

  // 7-bit global branch history register
  logic [6:0] ghr;

  // Index calculation
  logic [6:0] index;

  always @(posedge clk or posedge areset) begin
    if (areset)
      ghr <= 7'b0;
    else if (predict_valid)
      ghr <= {ghr[5:0], predict_taken};
    else if (train_valid && train_mispredicted)
      ghr <= train_history;
  end

  assign index = predict_pc ^ ghr;

  always @(posedge clk) begin
    if (train_valid) begin
      if (train_taken) begin
        if (pht[train_pc ^ train_history] < 2'b11)
          pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1'b1;
      end else begin
        if (pht[train_pc ^ train_history] > 2'b00)
          pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1'b1;
      end
    end
  end

  assign predict_taken = pht[index][1];
  assign predict_history = ghr;

endmodule