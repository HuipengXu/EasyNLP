export CUDA_VISIBLE_DEVICES=$1

export exp_name="only_mem_attn_bert_tiny_lru_1e-6_1e-3_0127"
export dataset="./data/"
export MAX_MEMORY_SIZE=41
export MAX_TASK_NUM=100
export MAX_LABEL_NUM=12
export pretrain_model="./bert-base-cased"
export checkpoint_dir_base="./checkpoint"
export checkpoint_dir="./checkpoint/final"
export outputs='./output/output_con.txt'

python run_mell.py \
  --mode train \
  --train_type lifelong \
  --tables ${dataset} \
  --checkpoint_dir_base ${checkpoint_dir_base} \
  --slow_lr 1e-6  \
  --fast_lr 1e-3 \
  --learning_rate 1e-3 \
  --train_batch_size 32 \
  --sequence_length 64 \
  --epoch_num 8  \
  --logging_steps 50 \
  --max_label_num ${MAX_LABEL_NUM} \
  --max_task_num ${MAX_TASK_NUM} \
  --max_memory_size ${MAX_MEMORY_SIZE} \
  --master_port 24567 \
  --use_lru


python run_mell.py \
  --mode=predict \
  --tables=${dataset} \
  --outputs=${outputs}$ \
  --checkpoint_dir=${checkpoint_dir}$ \
  --max_label_num ${MAX_LABEL_NUM} \
  --max_task_num ${MAX_TASK_NUM} \
  --max_memory_size ${MAX_MEMORY_SIZE} \
  --use_lru
