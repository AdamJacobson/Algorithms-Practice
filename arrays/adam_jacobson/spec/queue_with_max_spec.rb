require 'queue_with_max'

describe QueueWithMax do
  it "enqueues" do
    q = QueueWithMax.new
    5.times do |i|
      q.enqueue(i)
    end
    expect(q.length).to eq(5)
  end

  it "dequeues" do
    q = QueueWithMax.new
    5.times do |i|
      q.enqueue(i)
    end
    5.times do
      q.dequeue
    end
    expect(q.length).to eq(0)
  end

  it 'returns the correct max while enqueuing' do
    q = QueueWithMax.new
    arr = [1,3,4,10,9]
    5.times do |i|
      max = arr[0..i].max
      q.enqueue(arr[i])
      expect(q.max).to eq(max)
    end
  end

  it 'returns the correct max while dequeuing' do
    q = QueueWithMax.new
    arr = [1,3,4,10,9,3,2,17,5]
    arr.each { |el| q.enqueue(el) }
    (1...arr.length).each do |i|
      max = arr[i..-1].max
      q.dequeue
      expect(q.max).to eq(max)
    end
  end

  it 'returns the correct max while enqueuing and dequeuing' do
    q = QueueWithMax.new

    q.enqueue(6) # [6]
    expect(q.max).to eq(6)

    q.enqueue(5) # [6, 5]
    expect(q.max).to eq(6)

    q.enqueue(1) # [6, 5, 1]
    expect(q.max).to eq(6)

    q.enqueue(3) # [6, 5, 1, 3]
    expect(q.max).to eq(6)

    q.dequeue # [5, 1, 3]
    expect(q.max).to eq(5)

    q.dequeue # [1, 3]
    expect(q.max).to eq(3)

    q.dequeue # [3]
    expect(q.max).to eq(3)

    q.enqueue(10) # [3, 10]
    expect(q.max).to eq(10)
  end
end
