import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Text "mo:base/Text";


actor Token {
  var owner : Principal = Principal.fromText("vpbed-yyleh-an7du-k73lt-rcgvz-ogtcb-ufklk-libdg-gkroq-dywyp-3ae");
  var totalSupply :Nat = 1000000000;
  var symbol : Text = "FAD";
  var balances = HashMap.HashMap< Principal,Nat >(1, Principal.equal, Principal.hash);

  balances.put(owner, totalSupply);

  public query func balancesOf(who: Principal) : async Nat{
    let balance : Nat = switch (balances.get(who)){
      case null 0;
      case (?result) result;
    };
   return balance;
  };
  public query func getSymbol(): async Text{
    return symbol
  };
  public shared(msg)func payOUt() : async Text{

    if(balances.get(msg.caller)==null){
      let amount = 10000;
      balances.put(msg.caller, amount);
      return "Success"

    }else{
      return "Already Acquired Tokens"
    }; 
  };
  public func transfer(){
    
  }
};
