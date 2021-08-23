---
date: 2021-08-22 19:47
tags: tech diarios, SwiftUI, swift, Sean Allen, environment variable, 
---
# SwiftUI Sean Allen course notes


## I finally finished the sean allen SwiftUI course and here’s what I’ve gotten through his awesome course  

- If you’re not going to get a subclass from your class, make it final.

- Concepts of declarative(SwiftUI) and imperative(UIKit).

- In integrating SwiftUI with UIKit, what is happening is that the body in SwiftUI is being replaced by a ViewController.

- State variables (@State) are unique for each view and they are private.

- We must be careful using bindings, because for example if you pass binding through 5 views they all would be tight together.

- When we’re conforming to UIViewControllerRepresentable we must add protocol stubs which Xcode would yell at us about, but what the IDE suggests isn’t the exact type which we’d want to have. In order to fix this here’s the tricky line:

```  

​  Typealias UIViewControllerType = YourClassViewController​  
​  
```  
​And after Command + B we would get proper stubs; so you can remove tricky line.
 

- When we are going to pass a viewModel between views we use @ObservedObject instead of @StateObject

- In code navigationTitle goes inside the NavigationView and outside the inside view :)) 

```  

​  NavigationView {
​    Text("Navigation List View").navigationTitle("🍟 Appetizers") 
​  }​  
​  
```   
  
- Instead of having a list with id, we can conform our model to Identifiable and remove the id

```  

  struct Appetizer: Decodable 
    List(MockData.appetizer, id: \.id) { appetizer in
      Text(appetizer.name)
  }​  
​  
```  
  
```  

  struct Appetizer: Decodable, Identifiable
    List(MockData.appetizer) {  appetizer in
      Text(appetizer.name)
  }​  
  ​  
```  

- L means local variable here  

<p align="center">
<img src="/SwiftUI/local-variable.png" style="border-radius:3%">
</p>

- Setting data in SwiftUI must be in main queue


```  

  NetworkManager.shared.getAppetizers { (result) in
    DispatchQueue.main.async {
      switch result {
        case .success(let appetizers):
          self.appetizers = appetizers  
        case .failure(let error):
          print(error.localizedDescription)
        } 
      }        
    }
    
```

  - We use main queues for changes in UI that's why when Sean had a class with a published property that changes the UI, he set edits on the variable to be in a main queue

    ```  

    final class ImageLoader: ObservableObject {
      @Published var image: Image? = nil 
      
      func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { (uiImage) in
          guard let uiImage = uiImage else { return }
          DispatchQueue.main.async {
            self.image = Image(uiImage: uiImage)
          }
        }
      }
    }

```

    - There was a way that people usually create lists as we had at the first of the course  
    
```

      List(viewModel.appetizers) { appetizer in
        AppetizerListCell(appetizer: appetizer)
        .onTapGesture {
          viewModel.selectedAppetizer = appetizer
          viewModel.isShowingDetail = true
        }
      }

```  

      but if you want to provide swipe to delete action you must create your list in a different way

```

      List {
        ForEach(orderItems) { appetizer in
          AppetizerListCell(appetizer: appetizer)
        }
        .onDelete(perform: { indexSet in
          orderItems.remove(atOffsets: indexSet)
        })
      }

```
- Command + Shift + A = switch dark mode and light mode in simulator.
- If you've come from UIKit like me, we always tend to know what's really going on behind the code, and same here in SwiftUI I couldn't understand well enough how @State works, because structs are value types and each time they change we would have a new one in storage. 
- So I figure it out:when a state variable changes, what SwiftUI would understand is that the view is invalid and so recomputed the whole body again.
- What I thought before on @Binding was like the "inout" keyword, but I was wrong. The two variables aren't the same in storage, with binding we bind the second variable into the source of truth.
- Another way to use an environment object is when you want to pass a binding object down more than three views, you can use environment object instead.

### And for last here's the github repos:  
- [Weather](https://github.com/masein/weather-swift-ui)  
- [Appetizer](https://github.com/masein/appetizer-swift-ui)    
- [Apple Frameworks](https://github.com/masein/apple-frameworks-swift-ui)

