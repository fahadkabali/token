import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";


actor Token {
  let owner : Principal = Principal.fromText("vpbed-yyleh-an7du-k73lt-rcgvz-ogtcb-ufklk-libdg-gkroq-dywyp-3ae");
  let totalSupply :Nat = 1000000000;
  let symbol : Text = "FAD";

  private stable var balanceEntries:[(Principal, Nat)] = [];

  private var balances = HashMap.HashMap< Principal,Nat >(1, Principal.equal, Principal.hash);
  if(balances.size() < 1){
      balances.put(owner,totalSupply);
    };

  // balances.put(owner, totalSupply);

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

      let result = await transfer(msg.caller, amount);
      return result;

    }else{
      return "Already Acquired Tokens";
    }; 
  };
  public shared(msg) func transfer(to:Principal, amount:Nat): async Text{
    let fromBalance = await  balancesOf(msg.caller);
    if(fromBalance > amount ){
      let newFromBalance:Nat = fromBalance - amount;
      balances.put(msg.caller,newFromBalance);
      let toBalance = await balancesOf(to);
      balances.put(to,toBalance + amount);
      return "Transfer Successful!";
    }else{
      return "Not enough tokens in your account.";
    }

  };
  system func preupgrade(){
    balanceEntries := Iter.toArray(balances.entries());
  };
  system func postupgrade(){
    balances := HashMap.fromIter<Principal,Nat>(balanceEntries.vals(),1,Principal.equal,Principal.hash);
    if(balances.size() < 1){
      balances.put(owner,totalSupply);
    };
  };
  
};