int findMostFrequent(List<int> nums) {
  final frequencyMap = <int, int>{};

  for (var num in nums) {
    frequencyMap[num] = (frequencyMap[num] ?? 0) + 1;
  }

  int mostFrequent = nums[0];
  int maxFrequency = 0;

  frequencyMap.forEach((num, frequency) {
    if (frequency > maxFrequency) {
      maxFrequency = frequency;
      mostFrequent = num;
    }
  });

  return mostFrequent;
}
