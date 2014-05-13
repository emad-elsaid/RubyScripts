# simple sorting algorithms with ruby


```ruby
#!/usr/bin/env ruby
```
Author : Emad Elsaid (https://github.com/blazeeboy)

this script is a small practice in implementing
simple sorting algorithms in ruby, i converted
the sorting algorithms from wikipedia pages
```ruby

class Array
```
Insertion sort is a simple sorting algorithm that builds
the final sorted array (or list) one item at a time.
It is much less efficient on large lists than more advanced
algorithms such as quicksort, heapsort, or merge sort.
**wikipedia**
```ruby
  def insertion_sort!

    (1...size).each do |i|
      j = i
      while j > 0 and self[j-1] > self[j]
          self[j], self[j-1] = self[j-1], self[j]
          j = j - 1
      end
    end

  end

```
selection sort is a sorting algorithm, specifically an in-place
comparison sort. It has O(n2) time complexity, making it
inefficient on large lists, and generally performs worse
than the similar insertion sort. Selection sort is noted for
its simplicity, and it has performance advantages over more
complicated algorithms in certain situations,
particularly where auxiliary memory is limited.
**wikipedia**
```ruby
  def selection_sort!
     
    (0...size).each do |j|
```
find index of minimum element in the unsorted part
```ruby
      iMin = j
      (j+1...size).each do |i|
        iMin = i if self[i] < self[iMin]
      end
      
```
then swap it
```ruby
      self[j], self[iMin] = self[iMin], self[j]
    end
  end

end

```
lets try our algorithms
```ruby
x = (1..10).to_a.shuffle
p 'before sort : ', x
x.insertion_sort!
p 'after sort : ', x

x.shuffle!
p 'before sort : ', x
x.selection_sort!
p 'after sort : ', x```