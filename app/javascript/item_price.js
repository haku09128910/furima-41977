const price = () => {
  console.log("OK");

  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value; // 文字列として取得
      console.log(inputValue);

      // 数値に変換（入力が空なら0を代入）
      const numericValue = parseInt(inputValue, 10) || 0;

      const taxRate = 0.1; // 販売手数料（10%）
      const taxAmount = Math.floor(numericValue * taxRate); // 小数点以下切り捨て
      const profitAmount = numericValue - taxAmount; // 販売利益を計算

      addTaxDom.innerHTML = taxAmount.toLocaleString(); // 手数料を表示
      profitDom.innerHTML = profitAmount.toLocaleString(); // 利益を表示
    });
  }
};

// ページロード時と Turbo の再描画時に価格計算を実行
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);