FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # 「task」のように実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを作成されます
  factory :task do
    title { 'paperasse' }
    content { 'Préparez une proposition.' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # 「second_task」のように存在しないクラス名をつける場合、`class`オプションを使ってどのクラスのテストデータを作成するかを明示する必要がります
  factory :second_task, class: Task do
    title { 'envoyer un courriel' }
    content { 'Envoyez des courriels de vente aux clients.' }
  end
end
