# Rating Display
The rating display consist of either a one or five star rating. The star is configurable.

## Specifications
The rating specifications on Zeroheight is [here](https://spark.adevinta.com/1186e1705/p/63e136-rating/b/51f5d8).

![Figma anatomy](https://github.com/adevinta/spark-ios-component-rating/blob/main/.github/assets/anatomy.png)

Both a single rating star and the rating display are configured using the same component. 

## RatingUIView / RatingView Initialization
Initialization Parameters
* `theme: Theme`. The current theme
* `intent: RatingIntent.` The current rating intent. (At the moment, there is just one).
* `count: RatingStarsCount`. The number of rating stars. The default is  = `.five`.
* `size: RatingDisplaySize`. The size of the rating starts. The default is  = `.medium`.
* `rating: CGFloat`. The current rating value. The default is = `0.0`. The rating value should be in the range [0...5]
* `fillMode: StarFillMode`. How the partial rating star is to be filled. The default is `.half`.
* `configuration: StarConfiguration`.  A configuration defining the appearance of the star. The default is `.default`.

# Rating Input
The Rating Input is a control for setting the rating. There is only one size for the rating input, and five stars are always shown. It is not possible to remove a rating, or more precisely to set the value to 0, only programmatically. With the rating input, only whole numbers in the range between [1...5] can be entered.

In SwiftUI the changes will be bound to a binding which is passed in at initialization.
In UIKit the changes may be retrieved by 1) subscribing to the publisher, 2) adding a value changed target action, 3) adding a delegate.

## Initialization SwiftUI
* `theme: Theme`. The current theme.
* `intent: RatingIntent`. The intent defining the colors. (Currently there is only one intent `main`).
* `rating: Binding<CGFloat>`. A binding for setting the rating value. The set values will be whole numbers in the range [1...5].
* `configuration: StarConfiguration`. A configuration of the shape of the star. This has a default value `.default`.

## Initialization 
* `theme: Theme`. The current theme.
* `intent: RatingIntent`. The intent defining the colors. (Currently there is only one intent `main`).
* `rating: CGFloat`. The current rating. This will only be rendered as a whole number rating.
* `configuration: StarConfiguration`. A configuration of the shape of the star. This has a default value `.default`.

## License

```
MIT License

Copyright (c) 2024 Adevinta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
