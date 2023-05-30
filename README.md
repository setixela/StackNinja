                  
St/\ck Ninj/\ - App constructor framework
-------------------------------------------

<pre><code>                                   
                               Architecture overview

             ┌────────────────────────────────────────────────────────┐
             │                                                        │
             │                         ASSET                          │
             │                                                        │
             └────────────────────────────────────────────────────────┘
                      ▼                                       ▼
                 ┌─────────┐                             ┌─────────┐
                 │ SERVICE │                             │ DESIGN  │
                 └─────────┘                             └─────────┘
                      ▼                                       ▼
             ┌────────────────┐   ┌───────────────┐   ┌───────────────┐
             │                │   │               │   │               │
             │   ASYNC WORKS  │◄──┤   SCENARIO    │◄──┤     SCENE     │
             │                │   │               │   │               │
             ├────────────────┤   ├───────────────┤   ├───────────────┤
             │                │   │               │   │               │
             │                │   │  ┌─────────┐  │   │  ┌─────────┐  │  ┌────────┐
             │                │   │  │ EVENT A │◄─┼───┼──┤         ├──┼─►│        │
             │                │   │  └────┬────┘  │   │  │  VIEW   │  │  │ VIEW A │
             │                │   │       │       │   │  │ MODEL 1 │  │  │        │
             │                │   │       ▼       │   │  │         │  │  │        │
             │   ┌────────┐ ◄─┼───┼──── DOWORK    │   │  │         │◄─┼──┤        │
             │   │ WORK 1 │   │   │               │   │  │         │  │  └────────┘
             │   └────────┘ ──┼───┼───────┐       │   │  │         │  │            
             │                │   │       ▼       │   │  │         │  │  ┌────────┐
┌─────────┐  │   ┌────────┐ ◄─┼───┼──── DOWORK    │   │  │         ├──┼─►│        │
│ SERVICE │◄─┼──►│ WORK 2 │   │   │               │   │  │         │  │  │ VIEW B │
│   API   │  │   └────────┘ ──┼───┼───────┐       │   │  │         │  │  │        │
└─────────┘  │                │   │       ▼       │   │  │         │  │  │        │
             │                │   │    SETSTATE ──┼───┼─►│         │◄─┼──┤        │
             │                │   │               │   │  └─────────┘  │  └────────┘
             │                │   │               │   │               │            
             │                │   │  ┌─────────┐  │   │  ┌─────────┐  │  ┌────────┐
             │                │   │  │ EVENT B │◄─┼───┼──┤         ├──┼─►│        │
             │                │   │  └────┬────┘  │   │  │  VIEW   │  │  │ VIEW C │
             │                │   │       │       │   │  │ MODEL 2 │  │  │        │
             │                │   │       ▼       │   │  │         │  │  └────────┘
             │   ┌────────┐ ◄─┼───┼──── DOWORK    │   │  │         │  │            
             │   │ WORK 3 │   │   │               │   │  │         │  │  ┌────────┐
             │   └────────┘ ──┼───┼───────┐       │   │  │         ├──┼─►│        │
             │                │   │       ▼       │   │  │         │  │  │ VIEW D │
             │                │   │    SETSTATE ──┼───┼─►│         │◄─┼──┤        │
             │                │   │       │       │   │  └─────────┘  │  └────────┘
             │                │   │       ▼       │   │               │            
┌─────────┐  │   ┌────────┐ ◄─┼───┼──── DOWORK    │   │  ┌─────────┐  │  ┌────────┐
│         │◄─┼── │ WORK 4 │   │   │               │   │  │         ├──┼─►│        │
│ SERVICE │  │   └────────┘ ──┼───┼───────┐       │   │  │  VIEW   │  │  │ VIEW E │
│ STORAGE │  │                │   │       ▼       │   │  │ MODEL 3 │  │  │        │
│         │  │   ┌────────┐ ◄─┼───┼──── DOWORK    │   │  │         │  │  │        │
│         ├──┼─► │ WORK 5 │   │   │               │   │  │         │  │  └────────┘
└─────────┘  │   └────────┘ ──┼───┼───────┐       │   │  │         │  │            
             │                │   │       ▼       │   │  │         │  │  ┌────────┐
             │                │   │    SETSTATE ──┼───┼─►│         ├──┼─►│        │
             │                │   │               │   │  │         │  │  │ VIEW F │
             │                │   │               │   │  │         │  │  │        │
             │                │   │               │   │  └─────────┘  │  └────────┘
             │                │   │               │   │               │            
             └────────────────┘   └───────────────┘   └───────────────┘             
</code></pre>                                                                                        
             
             
Async Scenario example:
-----------------------
<pre><code>      
import StackNinja

struct BenefitBasketScenarioScenarioInput: ScenarioEvents {
   let deleteItemPressed: Out<Int>
   let countPlussPressed: Out<Int>
   let countMinusPressed: Out<Int>

   let checkMarkPressed: Out<(Bool, index: Int)>
   let tableItemPressed: Out<Int>
   let buyButtonPressed: Out<Void>

   let confirmDelete: Out<Void>
   let cancelDelete: Out<Void>
}

struct BenefitBasketScenarioParams<Asset: ASP>: ScenarioParams {
   typealias ScenarioInputEvents = BenefitBasketScenarioScenarioInput
   typealias ScenarioModelState = BenefitBasketState
   typealias ScenarioWorks = BenefitBasketWorks<Asset>
}

final class BenefitBasketScenario<Asset: ASP>: BaseParamsScenario<BenefitBasketScenarioParams<Asset>> {
   override func configure() {
      super.configure()

      // MARK: - load items at start

      start
         .doNext(works.loadCartItemsFromService)
         .doVoidNext(works.getBasketItems)
         .onSuccess(setState) { .presentBasketItems($0) }
         .onFail(setState, .presentLoadingError)

      // MARK: - quantity count change

      events.countPlussPressed
         .doNext(works.increaseItemAmount)
         .onSuccess(setState) { .updateItemAtIndex($0.0, $0.1) }
         .onFail(setState) { (item: CartItem, ind: Int) in [.updateItemAtIndex(item, ind), .connectionError] }
         .doVoidNext(works.getBasketItems)
         .onSuccess(setState) { .updateSummaAndButton($0) }

      events.countMinusPressed
         .doNext(works.decreaseItemAmount)
         .onSuccess(setState) { .updateItemAtIndex($0.0, $0.1) }
         .onFail(setState) { (item: CartItem, ind: Int) in [.updateItemAtIndex(item, ind), .connectionError] }
         .doVoidNext(works.getBasketItems)
         .onSuccess(setState) { .updateSummaAndButton($0) }

      // MARK: - checkmark works

      events.checkMarkPressed
         .doNext(works.updateCheckbox)
         .onSuccess(setState) { .updateItemAtIndex($0.0, $0.1) }
         .onFail(setState) { (item: CartItem, ind: Int) in [.updateItemAtIndex(item, ind), .connectionError] }
         .doVoidNext(works.getBasketItems)
         .onSuccess(setState) { .updateSummaAndButton($0) }

      // MARK: - item select and push details

      events.tableItemPressed
         .doSaveResult()
         .doVoidNext(works.getBasketItems)
         .onSuccessMixSaved(setState) { .presentBenefitDetails(id: $0[$1].offerId) }

      // MARK: - buying

      events.buyButtonPressed
         .onSuccess(setState, .presentFullScreenDarkLoader)
         .doNext(works.postOrders)
         .onSuccess(setState, .finishBuyOffers)
         .onFail(setState, .presenBuyError)

      // MARK: - deleting

      events.deleteItemPressed
         .onSuccess(setState, .presentDeleteAlert)

      Work.startVoid.retainBy(works.retainer)
         // catch index at "deleteItemPressed" and await "confirmDelete"
         .doCombine(events.deleteItemPressed, events.confirmDelete)
         .doMap { $0.0 }
         .doNext(works.deleteCartItemAtIndex)
         .onFail(setState, .deleteItemError)
         .doNext(works.getBasketItems)
         .onSuccess(setState) { .presentBasketItems($0) }

      Work.startVoid.retainBy(works.retainer)
         // catch index at "deleteItemPressed" and await "cancelDelete"
         .doCombine(events.deleteItemPressed, events.cancelDelete)
         .doVoidNext(works.getBasketItems)
         .onSuccess(setState) { .presentBasketItems($0) }
   }
}
</code></pre>
             
