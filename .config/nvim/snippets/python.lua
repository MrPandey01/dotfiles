return {

  s({ trig = "fig_matplotlib", wordTrig = true, dscr = 'matplotlib figure' },
    fmta(
      [[
      fig, ax = plt.subplots(<>, <>, sharex=<>) 
      ax.plot(<>, label='<>', lw=1) 
      ax.grid() 
      ax.legend(loc="upper right") 
      plt.xlabel('Time steps') 
      plt.title("dataset") 
      plt.tight_layout(pad=0.2) 
      # plt.savefig(f"{save_dir}/plot.svg", format="svg", dpi=800) 
      plt.show() 
      ]],
      {
        i(1, "1"),
        i(2, "1"),
        i(3, "False"),
        i(4, "x"),
        i(5, "plot"),
      }
    )
  ),

  s({ trig = "import_common", wordTrig = true, dscr = 'import matplotlib, torch, pandas' },
    fmta(
      [[
      import matplotlib.pyplot as plt
      import torch
      import pandas as pd

      plt.style.use("seaborn-bright")

      pd.set_option("display.max_rows", None)
      pd.set_option("display.max_columns", None)
      pd.set_option("display.width", 1000)
      pd.set_option("display.colheader_justify", "center")
      pd.set_option("display.precision", 3)
      <>
      ]],
      {
        i(0, " "),
      }
    )
  ),

}
