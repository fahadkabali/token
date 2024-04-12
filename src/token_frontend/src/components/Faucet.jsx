import React, { useState } from "react";
import { token_backend } from "../../../declarations/token_backend";

function Faucet() {
  const [isDisabled, setDisabled] =useState(false)
  const [buttonText, setText] =useState("Get Free Tokens")

  async function handleClick(event) {
    setDisabled(true)
    const result = await token_backend.payOut();
    setText(result)
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DFahd tokens here! Claim 10,000 DFAHD coins to your account.</label>
      <p className="trade-buttons">
        <button 
        id="btn-payout"
         onClick={handleClick}
         disabled={isDisabled}
         >
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;
