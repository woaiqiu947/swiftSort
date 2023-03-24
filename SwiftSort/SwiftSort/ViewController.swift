//
//  ViewController.swift
//  SwiftSort
//
//  Created by woaiqiu947 on 2023/3/24.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [2,3,4,1,6,7,5]
        bubbleSort(&arr)
        print("排序后的数组：\(arr)")
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    /// 冒泡排序
    /// - Parameter array: 数组
    /// - Returns: 排序后的数组
    func bubbleSort(_ array: [Int]) -> [Int] {
        var sortedArray = array
        let count = sortedArray.count
        for i in 0..<count {
            for j in 1..<count-i {
                if sortedArray[j-1] > sortedArray[j] {
                    let temp = sortedArray[j-1]
                    sortedArray[j-1] = sortedArray[j]
                    sortedArray[j] = temp
                }
            }
        }
        return sortedArray
    }

    /// 冒泡排序2
    /// - Parameter array: 数组
    /// - Returns: 排序后的数组
    func bubbleSort(_ arr: inout [Int]) {
        let n = arr.count
        for i in 0..<n-1 {
            var swapped = false
            for j in 0..<n-i-1 {
                if arr[j] > arr[j+1] {
                    arr.swapAt(j, j+1)
                    swapped = true
                }
            }
            if !swapped {
                break
            }
            Swift.print("???")
            Swift.print("第 \(i+1) 轮排序后的数组：\(arr)")
        }
    }
    
    /// 插入排序
    /// - Parameter nums: 数组
    func insertionSort(_ nums: inout [Int]) {
        let count = nums.count
        guard count > 1 else { return }
        for i in 1..<count {
            let value = nums[i]
            var j = i - 1
            while j >= 0 && nums[j] > value {
                nums[j+1] = nums[j]
                j -= 1
            }
            nums[j+1] = value
        }
    }
    
    /// 插入排序2
    /// - Parameter array: 数组
    func insertionSort<T: Comparable>(_ array: inout [T]) {
        guard array.count > 1 else {
            return
        }
        
        for i in 1..<array.count {
            var j = i
            let temp = array[j]
            while j > 0 && temp < array[j-1] {
                array[j] = array[j-1]
                j -= 1
            }
            array[j] = temp
        }
    }

    
    
    /// 选择排序
    /// - Parameter array: 数组
    func selectionSort<T: Comparable>(_ array: inout [T]) {
        guard array.count > 1 else {
            return
        }
        
        for i in 0..<array.count-1 {
            var minIndex = i
            for j in i+1..<array.count {
                if array[j] < array[minIndex] {
                    minIndex = j
                }
            }
            if i != minIndex {
                array.swapAt(i, minIndex)
            }
        }
    }

    
    /// 快速排序
    /// - Parameters:
    ///   - array: 数组
    ///   - low: ？
    ///   - high: ？
    func quickSort<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
        guard low < high else {
            return
        }
        
        let pivot = partition(&array, low: low, high: high)
        quickSort(&array, low: low, high: pivot-1)
        quickSort(&array, low: pivot+1, high: high)
    }

    func partition<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low
        for j in low..<high {
            if array[j] <= pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, high)
        return i
    }

    
    /// 快速排序2
    /// - Parameters:
    ///   - array: 数组
    ///   - low: ？
    ///   - high: ？
    func quickSort2<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
        guard low < high else { return }
        let pivot = array[high]
        var i = low
        for j in low..<high {
            if array[j] <= pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, high)
        
        // 打印每次循环的结果
        print(array)
        
        quickSort(&array, low: low, high: i - 1)
        quickSort(&array, low: i + 1, high: high)
    }

//    var array = [9, 7, 6, 4, 3, 2, 8, 5, 1]
//    quickSort(&array, low: 0, high: array.count - 1)

    /*
     以归并排序为例，最坏情况是指每次都要将待排序数组对半切分成两个长度相等的子数组，并进行合并。这种情况下，时间复杂度为 O(nlogn)。这是因为，归并排序的分治思想是将一个大问题分成两个相同或者相近的子问题，分别解决，最后合并结果。如果每次切分后两个子问题的规模相等，则需要递归地执行 O(logn) 次切分操作，每次切分操作需要 O(n) 的时间复杂度，合并操作需要 O(n) 的时间复杂度，所以最终的时间复杂度为 O(nlogn)。

     下面是一个最坏情况下归并排序的例子：
     */
    /// 归并排序
    /// - Parameter array: 数组
    /// - Returns: 返回
    func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else {
            return array
        }
        
        let mid = array.count / 2
        let left = mergeSort(Array(array[..<mid]))
        let right = mergeSort(Array(array[mid...]))
        return merge(left, right)
    }

    func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
        var leftIndex = 0
        var rightIndex = 0
        var result: [T] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            if left[leftIndex] < right[rightIndex] {
                result.append(left[leftIndex])
                leftIndex += 1
            } else {
                result.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        if leftIndex < left.count {
            result.append(contentsOf: left[leftIndex...])
        }
        
        if rightIndex < right.count {
            result.append(contentsOf: right[rightIndex...])
        }
        
        return result
    }
    
    func mergeSort2(_ arr: [Int]) -> [Int] {
        guard arr.count > 1 else { return arr }
        
        let mid = arr.count / 2
        let leftArr = mergeSort2(Array(arr[0..<mid]))
        let rightArr = mergeSort2(Array(arr[mid..<arr.count]))
        
        return merge2(leftArr, rightArr)
    }

    func merge2(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        var result = [Int]()
        var i = 0, j = 0
        
        while i < arr1.count && j < arr2.count {
            if arr1[i] < arr2[j] {
                result.append(arr1[i])
                i += 1
            } else {
                result.append(arr2[j])
                j += 1
            }
        }
        
        while i < arr1.count {
            result.append(arr1[i])
            i += 1
        }
        
        while j < arr2.count {
            result.append(arr2[j])
            j += 1
        }
        
        return result
    }



    /*
     let arr = [9, 8, 7, 6, 5, 4, 3, 2, 1]
     let sortedArr = mergeSort2(arr)
     print(sortedArr) // [1, 2, 3, 4, 5, 6, 7, 8, 9]
     在这个例子中，待排序数组的长度为 9，每次切分后的子数组长度都为 4 和 5，需要递归执行 3 次，每次合并操作的时间复杂度为 O(n)。因此，总时间复杂度为 O(nlogn)。
     */
    
    /// 希尔排序
    /// - Parameter array: 数组
    func shellSort<T: Comparable>(_ array: inout [T]) {
        let n = array.count
        var gap = n / 2
        while gap > 0 {
            for i in gap..<n {
                let temp = array[i]
                var j = i
                while j >= gap && array[j - gap] > temp {
                    array[j] = array[j - gap]
                    j -= gap
                }
                array[j] = temp
            }
            gap /= 2
        }
    }
    /*
     在这个示例中，我们使用了一个变量 gap，它代表着排序时每次比较的元素之间的距离。我们先将 gap 初始化为数组长度的一半，然后不断缩小 gap 直到其为 1，这样就可以得到一个有序数组。

     在每次排序中，我们从第 gap 个元素开始，向前遍历整个数组，比较相邻的两个元素的大小，如果前一个元素大于后一个元素，就将它们交换位置。然后我们继续向前遍历数组，直到数组的末尾。

     在每次排序后，我们将 gap 除以 2，然后重复上述过程，直到 gap 变为 1，此时数组就已经排序完成了。

     需要注意的是，在这个示例中我们使用了 inout 关键字来表示将数组作为引用传递，以便在函数中可以直接修改传入的数组。
     */
    
//mark
    
    /// 堆排序
    /// - Parameter arr: arr
    func heapSort(_ arr: inout [Int]) {
        // 将数组构建成最大堆
        buildMaxHeap(&arr)
        
        // 交换堆顶元素和最后一个元素，并重新构建最大堆
        for i in stride(from: arr.count - 1, to: 0, by: -1) {
            arr.swapAt(0, i)
            maxHeapify(&arr, 0, i)
        }
    }

    // 构建最大堆
    func buildMaxHeap(_ arr: inout [Int]) {
        let len = arr.count
        for i in stride(from: len / 2 - 1, through: 0, by: -1) {
            maxHeapify(&arr, i, len)
        }
    }

    // 维护最大堆的性质
    func maxHeapify(_ arr: inout [Int], _ i: Int, _ len: Int) {
        let left = i * 2 + 1
        let right = i * 2 + 2
        var largest = i
        if left < len && arr[left] > arr[largest] {
            largest = left
        }
        if right < len && arr[right] > arr[largest] {
            largest = right
        }
        if largest != i {
            arr.swapAt(i, largest)
            maxHeapify(&arr, largest, len)
        }
    }

    /*
     在这个例子中，首先通过 buildMaxHeap 方法将原始数组构建成最大堆，然后从堆顶开始将堆顶元素和最后一个元素交换，重新构建最大堆。每次交换后，堆大小减一，这样就能保证已经排好序的元素不会再次被交换。

     在维护最大堆的过程中，我们需要比较当前节点和其左右子节点的大小，如果当前节点不是最大的，就将其和左右子节点中最大的那个交换位置，然后递归地维护子树的最大堆性质。

     堆排序的时间复杂度为 $O(n \log n)$，空间复杂度为 $O(1)$。
     */
    
    
    
    /*
     计数排序是一种线性时间复杂度（O(n+k)）的排序算法，其中 n 是待排序数据的个数，k 是待排序数据中最大值和最小值的差值加上 1。

     下面是使用 Swift 实现的计数排序的例子：
     */
    /// 计数排序
    /// - Parameter array: array
    func countingSort(_ array: inout [Int]) {
        let maxElement = array.max() ?? 0
        var countArray = [Int](repeating: 0, count: maxElement + 1) //这行代码创建了一个长度为maxElement+1的数组countArray，并将其所有元素初始化为0。其中maxElement代表排序数组中的最大元素值，因为计数排序需要知道排序数组的最大值来确定计数数组的长度。因此这个数组被用来存储待排序数组中各个元素出现的次数。
        for element in array {
            countArray[element] += 1
        }
        var z = 0
        for i in 0...maxElement {
            while countArray[i] > 0 {
                array[z] = i
                z += 1
                countArray[i] -= 1
            }
        }
    }

    /*
     首先，我们找到输入数组中的最大值，然后创建一个计数数组，并对每个元素计数。然后，我们使用计数数组来排序输入数组。我们遍历计数数组中的所有元素，并将输入数组中的元素按顺序添加到输出数组中。由于我们正在迭代的元素是整数，因此我们可以在计数数组中使用它作为索引。在添加每个元素之后，我们递减计数数组中的计数，并将指针 z 向前移动一位，以准备添加下一个元素。

     值得注意的是，计数排序只适用于输入数组中的元素是整数的情况，而且要求待排序数据范围不大，否则会占用太多内存。此外，计数排序不是原地排序算法，需要额外的内存空间来存储计数数组。
     */
    
    
    
    
    /*
     桶排序是一种排序算法，它的基本思想是将数组分割成若干个桶（bucket），每个桶内的元素值都在一个范围之内。然后对每个桶内的元素进行排序，最后将各个桶内的元素合并成一个有序序列。

     具体实现时，首先要确定桶的个数和每个桶所包含元素的范围。然后遍历原始数组，将每个元素放入相应的桶内。对每个桶内的元素进行排序，可以选择使用任何一种排序算法。最后将各个桶内的元素按照桶的顺序依次合并，得到排序后的结果。

     桶排序的时间复杂度是线性的，取决于桶的个数和每个桶内元素的排序算法的时间复杂度。

     下面是一个使用 Swift 实现的桶排序例子：
     */
    func bucketSort(_ array: inout [Double], bucketSize: Int) {
        if array.count < 2 { return }
        var minValue = array[0]
        var maxValue = array[0]
        for i in 1..<array.count {
            if array[i] < minValue {
                minValue = array[i]
            } else if array[i] > maxValue {
                maxValue = array[i]
            }
        }
        let bucketCount = Int(ceil((maxValue - minValue) / Double(bucketSize)))
        var buckets = [[Double]](repeating: [], count: bucketCount)
        for i in 0..<array.count {
            let bucketIndex = Int(floor((array[i] - minValue) / Double(bucketSize)))
            buckets[bucketIndex].append(array[i])
        }
        var sortedArray = [Double]()
        for i in 0..<buckets.count {
            var bucket = buckets[i]
            if bucket.count > 0 {
                if bucketCount == 1 {
                    sortedArray += bucket
                } else {
                    bucketSort(&bucket, bucketSize: bucketSize)
                    sortedArray += bucket
                }
            }
        }
        array = sortedArray
    }

    
    
    /*
     在这个例子中，我们将元素值分成了若干个桶，每个桶内的元素值的范围是 bucketSize。遍历原始数组，将每个元素放入相应的桶内，然后对每个桶内的元素进行排序，这里使用了插入排序。最后将各个桶内的元素按照桶的顺序依次合并，得到排序后的结果。
     */
    
    
    
    
    /*
     基数排序（Radix Sort）是一种非比较排序算法，将整数按位数切割成不同的数字，然后按每个位数分别比较，最终得到有序的结果。

     基数排序的思路是将待排序的数字拆分成多个位数，按照从低位到高位的顺序进行排序，最终得到有序的结果。其主要步骤如下：

     计算待排序数组中最大数的位数，得到最大位数maxDigit；
     从个位数开始，依次按照每一位的数字大小将待排序数组分配到对应的桶中；
     将所有桶中的数字按照顺序依次取出，得到一个新的有序数组；
     重复第2~3步，直到按照最高位排序完毕，得到最终的有序数组。
     在具体实现中，可以通过定义一个二维数组buckets来表示每一位上的数字，其中buckets[i][j]表示第i位上为数字j的元素数量。同时，还需要定义一个桶指针bucketIndex，表示每一个桶中下一个要存放元素的位置。

     具体的基数排序实现代码如下：
     */
    func radixSort(_ array: inout [Int]) {
        let maxDigit = getMaxDigit(array)
        var mod = 10, dev = 1
        for i in 0..<maxDigit {
            var buckets = Array(repeating: [Int](), count: 10)
            var bucketIndex = Array(repeating: 0, count: 10)
            for j in 0..<array.count {
                let num = (array[j] % mod) / dev
                buckets[num].append(array[j])
                bucketIndex[num] += 1
            }
            var index = 0
            for j in 0..<bucketIndex.count {
                for k in 0..<bucketIndex[j] {
                    array[index] = buckets[j][k]
                    index += 1
                }
            }
            mod *= 10
            dev *= 10
        }
    }

    func getMaxDigit(_ array: [Int]) -> Int {
        var maxNum = 0
        for num in array {
            maxNum = max(maxNum, num)
        }
        var digit = 1
        while maxNum >= 10 {
            maxNum /= 10
            digit += 1
        }
        return digit
    }

    /*
     
     */
}

